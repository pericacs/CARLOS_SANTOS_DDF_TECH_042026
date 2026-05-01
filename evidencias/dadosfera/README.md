# Evidências da Dadosfera

## 1. Objetivo

Esta pasta contém evidências visuais dos ativos criados e catalogados na Dadosfera para o case técnico.

---

## 2. Datasets carregados

| Dataset | Tabela na Dadosfera | Print |
|---|---|---|
| Customers | `PUBLIC.RAW_CUSTOMERS` | `catalogo/catalogo_raw_customers.png` |
| Orders | `PUBLIC.RAW_ORDERS` | `catalogo/catalogo_raw_orders.png` |
| Order Items | `PUBLIC.RAW_ORDER_ITEMS` | `catalogo/catalogo_raw_order_items.png` |
| Products | `PUBLIC.RAW_PRODUCTS` | `catalogo/catalogo_raw_products.png` |
| Payments | `PUBLIC.RAW_PAYMENTS` | `catalogo/catalogo_raw_payments.png` |
| Reviews | `PUBLIC.RAW_REVIEWS` | `catalogo/catalogo_raw_reviews.png` |
| Sellers | `PUBLIC.RAW_SELLERS` | `catalogo/catalogo_raw_sellers.png` |

---

## 3. Padrão utilizado

Como o ambiente exibiu os ativos no schema `PUBLIC`, a separação de camada foi representada pelo prefixo no nome da tabela:

```text
RAW_ = camada de dados brutos