"""
DAG: dag_ingestao_receita
Autor: Igor
Descrição: Coleta dados de receita de restaurante via APIs e salva em estrutura de Data Lake.
Data: 2025-07
"""

# Importação das classes e módulos necessários para orquestração de tarefas
from airflow import DAG
from airflow.operators.python import PythonOperator  # Permite executar funções Python como tarefas
from datetime import datetime, timedelta            # Manipulação de datas para agendamento
import os                                           # Manipulação de diretórios
import json                                         # Leitura e escrita de JSON
import gzip                                         # Compactação de arquivos .gz
import logging                                      # Sistema de log para auditoria
import requests                                     # Requisições HTTP para consumir APIs

# URL base das APIs que serão chamadas
API_BASE = "https://api.seurestaurante.com"

# Dicionário com os endpoints que serão ingeridos. Cada chave representa um tipo de dado.
ENDPOINTS = {
    "getFiscalInvoice": "/bi/getFiscalInvoice",
    "getGuestChecks": "/res/getGuestChecks",
    "getChargeBack": "/org/getChargeBack",
    "getTransactions": "/trans/getTransactions",
    "getCashManagementDetails": "/inv/getCashManagementDetails"
}

# Diretório onde os dados serão salvos — estruturado para formar um Data Lake particionado
DATA_LAKE_ROOT = "/opt/airflow/data_lake/receita/"

# Configuração do sistema de logging — ajuda a rastrear execução, falhas e sucesso das tarefas
logging.basicConfig(
    level=logging.INFO,                            # Nível de log mínimo (INFO)
    format="[%(asctime)s] %(levelname)s - %(message)s",  # Formato do log
    datefmt="%Y-%m-%d %H:%M:%S"                    # Formato da data no log
)

# Função chamada pela DAG para coletar e salvar dados de receita
def fetch_and_save_airflow(**context):
    # Data da execução da DAG (fornecida automaticamente pelo Airflow)
    bus_dt = context["ds"]

    # ID da loja que será utilizada como parâmetro — vem do parâmetro da task
    store_id = context["params"].get("store_id", "store_001")

    # Loop pelos endpoints definidos para coleta
    for name, path in ENDPOINTS.items():
        url = f"{API_BASE}{path}"  # Monta URL completa da API
        payload = {"busDt": bus_dt, "storeId": store_id}  # Parâmetros do POST

        try:
            response = requests.post(url, json=payload)   # Faz requisição POST
            response.raise_for_status()                   # Garante que o status seja 200, senão lança exceção
            content = response.json()                     # Converte resposta para JSON

            # Cria estrutura de diretórios particionada por endpoint, loja e data
            dt = datetime.strptime(bus_dt, "%Y-%m-%d")
            folder_path = os.path.join(
                DATA_LAKE_ROOT,
                f"endpoint={name}",
                f"loja={store_id}",
                f"ano={dt.year}",
                f"mes={dt.month:02}",
                f"dia={dt.day:02}"
            )
            os.makedirs(folder_path, exist_ok=True)  # Garante que diretório existe

            # Caminho completo do arquivo a ser salvo no formato compactado (.json.gz)
            file_path = os.path.join(folder_path, f"{name}.json.gz")
            with gzip.open(file_path, "wt", encoding="utf-8") as f:
                json.dump(content, f, ensure_ascii=False, indent=2)  # Salva conteúdo

            logging.info(f"[✓] Dados salvos: {file_path}")  # Log de sucesso da escrita

        # Captura falhas específicas de rede ou API
        except requests.exceptions.RequestException as e:
            logging.error(f"[X] Erro no endpoint {name}: {e}")

        # Captura qualquer outro erro inesperado
        except Exception as ex:
            logging.exception(f"[!] Erro inesperado: {ex}")

# Configurações padrão da DAG — aplicadas a todas as tarefas
default_args = {
    'owner': 'igor',                                # Nome do responsável
    'depends_on_past': False,                       # Não depende da execução anterior
    'retries': 2,                                   # Tenta 2 vezes em caso de falha
    'retry_delay': timedelta(minutes=2),            # Aguarda 2 minutos antes de tentar novamente
}

# Definição da DAG propriamente dita
with DAG(
    dag_id='dag_ingestao_receita',                  # Identificador único da DAG
    default_args=default_args,                      # Aplica config padrão
    description='Ingestão de dados de receita do Coco Bambu via APIs para Data Lake',
    schedule_interval='@daily',                     # Executa todo dia à meia-noite
    start_date=datetime(2025, 7, 24),               # Data inicial de execução
    catchup=False,                                  # Não executa execuções pendentes automaticamente
    tags=['coco_bambu', 'api', 'datalake']          # Tags para organização no Airflow UI
) as dag:

    # Definição da tarefa que chama a função `fetch_and_save_airflow`
    ingestao_api = PythonOperator(
        task_id='coletar_dados_receita',            # Nome da tarefa no Airflow
        python_callable=fetch_and_save_airflow,     # Função a ser executada
        provide_context=True,                       # Permite acesso ao contexto da DAG
        params={"store_id": "store_001"},           # Parâmetro personalizado passado à função
    )

    # Executa a tarefa
    ingestao_api
