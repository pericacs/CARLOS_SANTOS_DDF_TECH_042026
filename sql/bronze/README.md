# Camada Bronze

## Objetivo

A camada Bronze tem como objetivo padronizar os dados carregados na camada Raw da Dadosfera.

Nesta etapa, os dados ainda representam a origem original da base Olist, porém com ajustes mínimos para facilitar processamento, qualidade e integração nas próximas camadas.

---

## Origem

As tabelas Bronze são criadas a partir das tabelas Raw carregadas na Dadosfera:

| Raw | Bronze |
|---|---|
| `PUBLIC.RAW_ORDERS` | `PUBLIC.BRONZE_ORDERS` |
| `PUBLIC.RAW_ORDER_ITEMS` | `PUBLIC.BRONZE_ORDER_ITEMS` |
| `PUBLIC.RAW_CUSTOMERS` | `PUBLIC.BRONZE_CUSTOMERS` |
| `PUBLIC.RAW_PRODUCTS` | `PUBLIC.BRONZE_PRODUCTS` |
| `PUBLIC.RAW_PAYMENTS` | `PUBLIC.BRONZE_PAYMENTS` |
| `PUBLIC.RAW_REVIEWS` | `PUBLIC.BRONZE_REVIEWS` |
| `PUBLIC.RAW_SELLERS` | `PUBLIC.BRONZE_SELLERS` |

---

## Transformações Aplicadas

As principais transformações realizadas na camada Bronze são:

- conversão de campos de data para timestamp;
- conversão de campos numéricos para number/decimal;
- padronização de textos com `TRIM`, `LOWER` e `UPPER`;
- manutenção dos identificadores originais;
- criação da coluna técnica `BRONZE_CREATED_AT`;
- preparação dos dados para a camada Silver.

---

## Observação

Como o ambiente da Dadosfera utiliza o schema `PUBLIC`, a separação entre camadas foi representada por prefixos nos nomes das tabelas:

```text
RAW_
BRONZE_
SILVER_
GOLD_