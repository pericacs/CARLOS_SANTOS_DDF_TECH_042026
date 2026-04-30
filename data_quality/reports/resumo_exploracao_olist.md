# Relatório de Exploração Inicial - Base Olist

Este relatório apresenta uma análise exploratória inicial dos arquivos CSV da base Olist.

O objetivo é validar a estrutura dos dados, volume de registros, colunas disponíveis, dados nulos e possíveis duplicidades.

---

## 1. Resumo Geral

| Tabela | Arquivo | Linhas | Colunas | Duplicadas |
|---|---|---:|---:|---:|
| orders | olist_orders_dataset.csv | 99441 | 8 | 0 |
| order_items | olist_order_items_dataset.csv | 112650 | 7 | 0 |
| customers | olist_customers_dataset.csv | 99441 | 5 | 0 |
| products | olist_products_dataset.csv | 32951 | 9 | 0 |
| payments | olist_order_payments_dataset.csv | 103886 | 5 | 0 |
| reviews | olist_order_reviews_dataset.csv | 99224 | 7 | 0 |
| sellers | olist_sellers_dataset.csv | 3095 | 4 | 0 |
| geolocation | olist_geolocation_dataset.csv | 1000163 | 5 | 261831 |
| category_translation | product_category_name_translation.csv | 71 | 2 | 0 |

---

## 2. Detalhamento por Tabela

### 2.x orders

Arquivo: `olist_orders_dataset.csv`

Total de linhas: **99441**

Total de colunas: **8**

Total de linhas duplicadas: **0**

Colunas:

- `order_id`
- `customer_id`
- `order_status`
- `order_purchase_timestamp`
- `order_approved_at`
- `order_delivered_carrier_date`
- `order_delivered_customer_date`
- `order_estimated_delivery_date`

Resumo de nulos por coluna:

| coluna                        |   qtd_nulos |   perc_nulos | tipo_dado   |
|:------------------------------|------------:|-------------:|:------------|
| order_delivered_customer_date |        2965 |         2.98 | str         |
| order_delivered_carrier_date  |        1783 |         1.79 | str         |
| order_approved_at             |         160 |         0.16 | str         |
| customer_id                   |           0 |         0    | str         |
| order_estimated_delivery_date |           0 |         0    | str         |
| order_id                      |           0 |         0    | str         |
| order_purchase_timestamp      |           0 |         0    | str         |
| order_status                  |           0 |         0    | str         |

---

### 2.x order_items

Arquivo: `olist_order_items_dataset.csv`

Total de linhas: **112650**

Total de colunas: **7**

Total de linhas duplicadas: **0**

Colunas:

- `order_id`
- `order_item_id`
- `product_id`
- `seller_id`
- `shipping_limit_date`
- `price`
- `freight_value`

Resumo de nulos por coluna:

| coluna              |   qtd_nulos |   perc_nulos | tipo_dado   |
|:--------------------|------------:|-------------:|:------------|
| freight_value       |           0 |            0 | float64     |
| order_id            |           0 |            0 | str         |
| order_item_id       |           0 |            0 | int64       |
| price               |           0 |            0 | float64     |
| product_id          |           0 |            0 | str         |
| seller_id           |           0 |            0 | str         |
| shipping_limit_date |           0 |            0 | str         |

---

### 2.x customers

Arquivo: `olist_customers_dataset.csv`

Total de linhas: **99441**

Total de colunas: **5**

Total de linhas duplicadas: **0**

Colunas:

- `customer_id`
- `customer_unique_id`
- `customer_zip_code_prefix`
- `customer_city`
- `customer_state`

Resumo de nulos por coluna:

| coluna                   |   qtd_nulos |   perc_nulos | tipo_dado   |
|:-------------------------|------------:|-------------:|:------------|
| customer_city            |           0 |            0 | str         |
| customer_id              |           0 |            0 | str         |
| customer_state           |           0 |            0 | str         |
| customer_unique_id       |           0 |            0 | str         |
| customer_zip_code_prefix |           0 |            0 | int64       |

---

### 2.x products

Arquivo: `olist_products_dataset.csv`

Total de linhas: **32951**

Total de colunas: **9**

Total de linhas duplicadas: **0**

Colunas:

- `product_id`
- `product_category_name`
- `product_name_lenght`
- `product_description_lenght`
- `product_photos_qty`
- `product_weight_g`
- `product_length_cm`
- `product_height_cm`
- `product_width_cm`

Resumo de nulos por coluna:

| coluna                     |   qtd_nulos |   perc_nulos | tipo_dado   |
|:---------------------------|------------:|-------------:|:------------|
| product_category_name      |         610 |         1.85 | str         |
| product_description_lenght |         610 |         1.85 | float64     |
| product_name_lenght        |         610 |         1.85 | float64     |
| product_photos_qty         |         610 |         1.85 | float64     |
| product_height_cm          |           2 |         0.01 | float64     |
| product_length_cm          |           2 |         0.01 | float64     |
| product_weight_g           |           2 |         0.01 | float64     |
| product_width_cm           |           2 |         0.01 | float64     |
| product_id                 |           0 |         0    | str         |

---

### 2.x payments

Arquivo: `olist_order_payments_dataset.csv`

Total de linhas: **103886**

Total de colunas: **5**

Total de linhas duplicadas: **0**

Colunas:

- `order_id`
- `payment_sequential`
- `payment_type`
- `payment_installments`
- `payment_value`

Resumo de nulos por coluna:

| coluna               |   qtd_nulos |   perc_nulos | tipo_dado   |
|:---------------------|------------:|-------------:|:------------|
| order_id             |           0 |            0 | str         |
| payment_installments |           0 |            0 | int64       |
| payment_sequential   |           0 |            0 | int64       |
| payment_type         |           0 |            0 | str         |
| payment_value        |           0 |            0 | float64     |

---

### 2.x reviews

Arquivo: `olist_order_reviews_dataset.csv`

Total de linhas: **99224**

Total de colunas: **7**

Total de linhas duplicadas: **0**

Colunas:

- `review_id`
- `order_id`
- `review_score`
- `review_comment_title`
- `review_comment_message`
- `review_creation_date`
- `review_answer_timestamp`

Resumo de nulos por coluna:

| coluna                  |   qtd_nulos |   perc_nulos | tipo_dado   |
|:------------------------|------------:|-------------:|:------------|
| review_comment_title    |       87656 |        88.34 | str         |
| review_comment_message  |       58247 |        58.7  | str         |
| order_id                |           0 |         0    | str         |
| review_answer_timestamp |           0 |         0    | str         |
| review_creation_date    |           0 |         0    | str         |
| review_id               |           0 |         0    | str         |
| review_score            |           0 |         0    | int64       |

---

### 2.x sellers

Arquivo: `olist_sellers_dataset.csv`

Total de linhas: **3095**

Total de colunas: **4**

Total de linhas duplicadas: **0**

Colunas:

- `seller_id`
- `seller_zip_code_prefix`
- `seller_city`
- `seller_state`

Resumo de nulos por coluna:

| coluna                 |   qtd_nulos |   perc_nulos | tipo_dado   |
|:-----------------------|------------:|-------------:|:------------|
| seller_city            |           0 |            0 | str         |
| seller_id              |           0 |            0 | str         |
| seller_state           |           0 |            0 | str         |
| seller_zip_code_prefix |           0 |            0 | int64       |

---

### 2.x geolocation

Arquivo: `olist_geolocation_dataset.csv`

Total de linhas: **1000163**

Total de colunas: **5**

Total de linhas duplicadas: **261831**

Colunas:

- `geolocation_zip_code_prefix`
- `geolocation_lat`
- `geolocation_lng`
- `geolocation_city`
- `geolocation_state`

Resumo de nulos por coluna:

| coluna                      |   qtd_nulos |   perc_nulos | tipo_dado   |
|:----------------------------|------------:|-------------:|:------------|
| geolocation_city            |           0 |            0 | str         |
| geolocation_lat             |           0 |            0 | float64     |
| geolocation_lng             |           0 |            0 | float64     |
| geolocation_state           |           0 |            0 | str         |
| geolocation_zip_code_prefix |           0 |            0 | int64       |

---

### 2.x category_translation

Arquivo: `product_category_name_translation.csv`

Total de linhas: **71**

Total de colunas: **2**

Total de linhas duplicadas: **0**

Colunas:

- `product_category_name`
- `product_category_name_english`

Resumo de nulos por coluna:

| coluna                        |   qtd_nulos |   perc_nulos | tipo_dado   |
|:------------------------------|------------:|-------------:|:------------|
| product_category_name         |           0 |            0 | str         |
| product_category_name_english |           0 |            0 | str         |

---

## 3. Conclusão Inicial

A base Olist possui volume suficiente para o case técnico, com múltiplas tabelas relacionadas ao processo de e-commerce.

A partir desta exploração inicial, as próximas etapas serão:

- carregar os arquivos na Dadosfera;
- catalogar os datasets;
- aplicar regras de Data Quality;
- construir as camadas Bronze, Silver e Gold;
- criar modelo dimensional;
- desenvolver dashboards e Data App.
