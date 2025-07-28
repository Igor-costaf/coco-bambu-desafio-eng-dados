# Projeto de Engenharia de Dados - Coco Bambu

Este projeto tem como objetivo a ingestão, estruturação e análise de dados de um restaurante (como o Coco Bambu), com foco no endpoint `getGuestChecks`. As etapas envolvem ingestão de dados via APIs, organização em um Data Lake particionado, normalização para modelo relacional e orquestração com Airflow.

---

## Estrutura de Pastas Sugerida

```bash
├── data_lake/
│   └── receita/
│       ├── endpoint=getGuestChecks/
│       │   └── loja=store_001/
│       │       └── ano=2025/mes=07/dia=24/guest_checks.json
│       └── ... outros endpoints
├── ERP.json                  # JSON de exemplo com estrutura real de guestChecks
├── ingestao_apis.py         # Script de ingestão via linha de comando
├── dag_ingestao_receita.py  # DAG do Airflow para orquestração
├── inserts_restaurante_frutos_do_mar.sql  # Inserts exemplo para modelo relacional
├── CocoBambu.ipynb          # Notebook com transformações e queries
```

---

## Scripts Disponíveis

### `ingestao_apis.py`

Script que realiza requisição POST para os endpoints da API e salva as respostas JSON em formato `.json.gz`, em estrutura de pastas particionadas por:

- endpoint
- loja
- ano/mês/dia

**Uso via linha de comando:**

```bash
python ingestao_apis.py --data 2025-07-24 --loja store_001
```

### `dag_ingestao_receita.py`

DAG do Apache Airflow que agenda automaticamente a coleta de dados para uma loja, diariamente. O armazenamento segue a mesma estrutura particionada do script standalone.

### `CocoBambu.ipynb`

Notebook de exploração e modelagem dos dados, incluindo:

- Transformação de JSON para DataFrames
- Criação de tabelas relacionais em SQLite
- Queries analíticas (ex: ticket médio, impostos, itens mais vendidos)

### `coco_bambu_db`

Banco de dados relacional desenvolvido em MySQL com dados simulados, refletindo o funcionamento de um restaurante Coco Bambu, incluindo comandas, itens vendidos, impostos e pagamentos.

### `ERP.json`

Exemplo real da resposta da API `getGuestChecks`. Inclui:

- Campos como `guestCheckId`, `chkNum`, `opnUTC`, `taxes`, `detailLines`
- Itens de menu e impostos aplicados

---

## Padrão de Nomeação e Versionamento

- Os dados são salvos com nomes como `guest_checks.json.gz`
- O fallback de campos (ex: renomear `taxes` para `taxation`) é tratado via:

```python
imposto = guest.get("taxation") or guest.get("taxes")
```

---

## Benefícios e Justificativas

- **Data Lake particionado** por data/loja/endpoint garante escalabilidade e otimiza leitura.
- **Versionamento** implícito via estrutura de pastas.
- **Pipeline replicável e orquestrável**, via script standalone ou Airflow.
- **Modelo relacional** normalizado, ideal para BI e integração com Data Warehouses.

---

## Requisitos

- Python 3.8+
- Bibliotecas: `pandas`, `sqlalchemy`, `requests`, `gzip`, `argparse`
- Apache Airflow (para DAG opcional)

---

## Execução Recomendada

1. Rodar `ingestao_apis.py` para baixar dados:

```bash
python ingestao_apis.py --data 2025-07-24 --loja store_001
```

2. Rodar `CocoBambu.ipynb` no Google Colab ou localmente para transformar JSON em tabelas e fazer análises.
3. Agendar `dag_ingestao_receita.py` no Airflow para automação diária.

---

## Autor

Igor - Engenheiro de Dados
