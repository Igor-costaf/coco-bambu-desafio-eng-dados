"""
Script: ingestao_apis.py
Autor: Igor
Descrição: Faz ingestão de APIs de receita de restaurantes e salva dados em estrutura particionada no Data Lake.
Data: 2025-07
"""

# Importação de bibliotecas
import os                      # Manipulação de diretórios e caminhos
import json                    # Leitura e escrita de arquivos JSON
import gzip                    # Compressão de arquivos no formato .gz
import logging                 # Sistema de log para monitorar execuções
import requests                # Requisições HTTP para consumir APIs
import argparse                # Permite rodar o script via linha de comando com parâmetros
from datetime import datetime # Manipulação e formatação de datas

# Configurações globais
API_BASE = "https://api.seurestaurante.com"  # URL base da API (fictícia)
ENDPOINTS = {  # Dicionário de endpoints disponíveis para ingestão
    "getFiscalInvoice": "/bi/getFiscalInvoice",
    "getGuestChecks": "/res/getGuestChecks",
    "getChargeBack": "/org/getChargeBack",
    "getTransactions": "/trans/getTransactions",
    "getCashManagementDetails": "/inv/getCashManagementDetails"
}
DATA_LAKE_ROOT = "./data_lake/receita/"  # Diretório onde os dados serão salvos

# Configuração do logging — registra INFO, ERROR e EXCEPTION com timestamp
logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] %(levelname)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)

# Função principal que consome APIs e salva os dados compactados
def fetch_and_save(bus_dt: str, store_id: str):
    for name, path in ENDPOINTS.items():
        url = f"{API_BASE}{path}"  # Monta URL completa da API
        payload = {"busDt": bus_dt, "storeId": store_id}  # Define parâmetros da requisição

        try:
            response = requests.post(url, json=payload)  # Faz requisição POST à API
            response.raise_for_status()                  # Lança erro caso resposta não seja 200
            content = response.json()                    # Extrai conteúdo JSON da resposta

            # Monta o caminho de diretório por endpoint, loja e data
            dt = datetime.strptime(bus_dt, "%Y-%m-%d")
            folder_path = os.path.join(
                DATA_LAKE_ROOT,
                f"endpoint={name}",
                f"loja={store_id}",
                f"ano={dt.year}",
                f"mes={dt.month:02}",
                f"dia={dt.day:02}"
            )
            os.makedirs(folder_path, exist_ok=True)  # Cria diretórios se não existirem

            # Define caminho do arquivo e salva como .json.gz
            file_path = os.path.join(folder_path, f"{name}.json.gz")
            with gzip.open(file_path, "wt", encoding="utf-8") as f:
                json.dump(content, f, ensure_ascii=False, indent=2)

            logging.info(f"[✓] Dados salvos: {file_path}")  # Log de sucesso

        # Tratamento de erros de rede
        except requests.exceptions.RequestException as e:
            logging.error(f"[X] Falha no endpoint {name}: {e}")

        # Tratamento de erros inesperados
        except Exception as ex:
            logging.exception(f"[!] Erro inesperado para {name}: {ex}")

# ▶️ Executa via linha de comando com argumentos --data e --loja
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Ingestão de APIs de receita para Data Lake")
    parser.add_argument("--data", required=True, help="Data no formato YYYY-MM-DD")
    parser.add_argument("--loja", required=True, help="ID da loja (ex: store_001)")

    args = parser.parse_args()  # Lê os argumentos passados via CLI

    logging.info(f"Iniciando ingestão para loja={args.loja} na data={args.data}")
    fetch_and_save(args.data, args.loja)  # Chama função principal com os parâmetros
