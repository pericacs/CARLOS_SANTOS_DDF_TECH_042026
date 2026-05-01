# Camada Silver

## Objetivo

A camada Silver tem como objetivo tratar, enriquecer e integrar os dados da camada Bronze.

Nesta etapa, os dados passam a conter regras de negócio, classificações e métricas derivadas, ficando prontos para a construção da camada Gold.

---

## Tabelas Criadas

| Arquivo | Tabela | Descrição |
|---|---|---|
| `silver_orders_enriched.sql` | `PUBLIC.SILVER_ORDERS_ENRICHED` | Pedidos enriquecidos com dados do cliente e métricas de entrega |
| `silver_order_items_enriched.sql` | `PUBLIC.SILVER_ORDER_ITEMS_ENRICHED` | Itens enriquecidos com produto, categoria e vendedor |
| `silver_payments_enriched.sql` | `PUBLIC.SILVER_PAYMENTS_ENRICHED` | Pagamentos classificados por tipo e faixa de parcelamento |
| `silver_reviews_enriched.sql` | `PUBLIC.SILVER_REVIEWS_ENRICHED` | Reviews classificados por sentimento, risco e tópico |

---

## Principais Transformações

### Pedidos

- Enriquecimento com cidade e estado do cliente;
- Conversão de datas;
- Cálculo de dias até entrega;
- Cálculo de dias de atraso;
- Criação de flag de entrega atrasada;
- Classificação do status de entrega.

### Itens

- Enriquecimento com produto;
- Enriquecimento com vendedor;
- Cálculo do valor total do item;
- Classificação de preço;
- Classificação de frete.

### Pagamentos

- Padronização do tipo de pagamento;
- Tradução da forma de pagamento;
- Classificação por faixa de parcelamento;
- Validação do status do valor pago.

### Reviews

- Classificação do review em positivo, neutro ou negativo;
- Criação de flag de review negativo;
- Criação de flag de review positivo;
- Identificação de comentários preenchidos;
- Classificação de risco de insatisfação;
- Classificação simples de tópico do comentário.

---

## Fluxo

```text
PUBLIC.RAW_* 
    ↓
PUBLIC.BRONZE_* 
    ↓
PUBLIC.SILVER_*_ENRICHED
    ↓
PUBLIC.GOLD_*