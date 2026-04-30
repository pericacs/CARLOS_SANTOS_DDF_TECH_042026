# Instruções para Download da Base Olist

## 1. Base Escolhida

A base escolhida para este case é a **Brazilian E-Commerce Public Dataset by Olist**, disponível no Kaggle.

Link da base:

```text
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
```

Essa base contém dados públicos de e-commerce brasileiro, com aproximadamente 100 mil pedidos realizados entre 2016 e 2018 em múltiplos marketplaces.

A base foi escolhida porque possui um cenário realista para Engenharia de Dados, com informações relacionadas a:

- pedidos
- clientes
- vendedores
- produtos
- pagamentos
- entregas
- avaliações de clientes
- localização geográfica

---

## 2. Por que essa base atende ao case?

A base atende aos requisitos do case porque:

- possui aproximadamente 100 mil pedidos;
- contém múltiplas tabelas relacionais;
- permite análises comerciais, logísticas e de experiência do cliente;
- possui dados estruturados e desestruturados;
- permite aplicação de Data Quality;
- permite modelagem dimensional no padrão Kimball;
- permite criação de dashboard com múltiplas visualizações;
- permite uso de IA/LLM sobre os comentários dos clientes.

---

## 3. Arquivos utilizados no projeto

Após baixar e extrair o arquivo `.zip` do Kaggle, serão utilizados os seguintes arquivos CSV:

```text
olist_orders_dataset.csv
olist_order_items_dataset.csv
olist_customers_dataset.csv
olist_products_dataset.csv
olist_order_payments_dataset.csv
olist_order_reviews_dataset.csv
olist_sellers_dataset.csv
olist_geolocation_dataset.csv
product_category_name_translation.csv
```

---

## 4. Finalidade de cada arquivo

| Arquivo | Finalidade |
|---|---|
| `olist_orders_dataset.csv` | Informações principais dos pedidos, status e datas |
| `olist_order_items_dataset.csv` | Itens dos pedidos, produto, vendedor, preço e frete |
| `olist_customers_dataset.csv` | Dados dos clientes e localização |
| `olist_products_dataset.csv` | Dados cadastrais dos produtos |
| `olist_order_payments_dataset.csv` | Informações de pagamento dos pedidos |
| `olist_order_reviews_dataset.csv` | Notas e comentários dos clientes |
| `olist_sellers_dataset.csv` | Dados dos vendedores |
| `olist_geolocation_dataset.csv` | Dados de geolocalização por CEP |
| `product_category_name_translation.csv` | Tradução das categorias de produtos |

---

## 5. Estrutura local sugerida

Por limitação de tamanho e boas práticas de versionamento, os arquivos CSV originais não serão versionados no GitHub.

Os arquivos devem ser armazenados localmente na pasta:

```text
data/raw/
```

Exemplo:

```text
CARLOS_SANTOS_DDF_TECH_042026/
└── data/
    └── raw/
        ├── olist_orders_dataset.csv
        ├── olist_order_items_dataset.csv
        ├── olist_customers_dataset.csv
        ├── olist_products_dataset.csv
        ├── olist_order_payments_dataset.csv
        ├── olist_order_reviews_dataset.csv
        ├── olist_sellers_dataset.csv
        ├── olist_geolocation_dataset.csv
        └── product_category_name_translation.csv
```

---

## 6. Observação sobre versionamento

Os arquivos `.csv`, `.zip` e `.parquet` foram adicionados ao `.gitignore` para evitar que dados pesados sejam enviados ao repositório.

Trecho utilizado no `.gitignore`:

```gitignore
data/raw/
data/processed/
*.csv
*.parquet
*.zip
```

---

## 7. Como baixar pelo navegador

1. Acessar o Kaggle.
2. Fazer login na conta.
3. Acessar a página da base Brazilian E-Commerce Public Dataset by Olist.
4. Clicar em **Download**.
5. Extrair o arquivo `.zip`.
6. Copiar os arquivos `.csv` para a pasta `data/raw/`.

---

## 8. Como baixar via Kaggle API

Também é possível baixar a base utilizando a API do Kaggle.

### 8.1 Instalar a biblioteca do Kaggle

```bash
pip install kaggle
```

### 8.2 Configurar credenciais

No Kaggle, acessar:

```text
Account > API > Create New Token
```

Será baixado um arquivo chamado:

```text
kaggle.json
```

No Windows, colocar esse arquivo em:

```text
C:\Users\SEU_USUARIO\.kaggle\kaggle.json
```

### 8.3 Baixar a base

Executar o comando:

```bash
kaggle datasets download -d olistbr/brazilian-ecommerce -p data/raw
```

### 8.4 Extrair o arquivo

```bash
tar -xf data/raw/brazilian-ecommerce.zip -C data/raw
```

Caso esteja no Windows e o comando `tar` não funcione, é possível extrair manualmente pelo Explorer ou usar:

```powershell
Expand-Archive -Path data/raw/brazilian-ecommerce.zip -DestinationPath data/raw
```

---

## 9. Próxima etapa

Após baixar os arquivos, a próxima etapa será executar o notebook:

```text
notebooks/01_exploracao_olist.ipynb
```

Esse notebook será responsável por:

- validar a existência dos arquivos;
- contar registros de cada tabela;
- analisar colunas e tipos de dados;
- identificar campos nulos;
- identificar possíveis chaves;
- gerar primeiras estatísticas;
- apoiar a carga dos dados na Dadosfera.