# Dicionário de Dados - Base Olist

## 1. Objetivo

Este documento apresenta o dicionário de dados da base **Brazilian E-Commerce Public Dataset by Olist**, utilizada no case técnico da Dadosfera.

O objetivo é documentar as principais tabelas, colunas, chaves e finalidades de negócio, apoiando a catalogação dos ativos na Dadosfera e a criação das camadas analíticas.

---

## 2. Visão Geral das Tabelas

| Tabela | Arquivo | Descrição |
|---|---|---|
| `orders` | `olist_orders_dataset.csv` | Dados principais dos pedidos |
| `order_items` | `olist_order_items_dataset.csv` | Itens dos pedidos, produtos, vendedores, preço e frete |
| `customers` | `olist_customers_dataset.csv` | Dados cadastrais e localização dos clientes |
| `products` | `olist_products_dataset.csv` | Dados cadastrais dos produtos |
| `payments` | `olist_order_payments_dataset.csv` | Dados de pagamento dos pedidos |
| `reviews` | `olist_order_reviews_dataset.csv` | Avaliações e comentários dos clientes |
| `sellers` | `olist_sellers_dataset.csv` | Dados cadastrais e localização dos vendedores |
| `geolocation` | `olist_geolocation_dataset.csv` | Dados geográficos por prefixo de CEP |
| `category_translation` | `product_category_name_translation.csv` | Tradução das categorias de produto |

---

## 3. Tabela `orders`

### Descrição

Tabela principal de pedidos. Contém o status do pedido e as principais datas do ciclo de compra, aprovação, envio, entrega e estimativa de entrega.

### Chave principal

| Coluna | Tipo esperado | Descrição |
|---|---|---|
| `order_id` | string | Identificador único do pedido |

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `order_id` | string | Identificador único do pedido | Não nulo e único |
| `customer_id` | string | Identificador do cliente no pedido | Não nulo |
| `order_status` | string | Status atual do pedido | Deve estar em lista controlada |
| `order_purchase_timestamp` | datetime | Data e hora da compra | Não nulo |
| `order_approved_at` | datetime | Data e hora da aprovação | Pode ser nulo |
| `order_delivered_carrier_date` | datetime | Data de envio para transportadora | Pode ser nulo |
| `order_delivered_customer_date` | datetime | Data de entrega ao cliente | Pode ser nulo |
| `order_estimated_delivery_date` | datetime | Data estimada de entrega | Não nulo |

### Uso analítico

- Análise de volume de pedidos
- Evolução temporal de vendas
- Análise de status dos pedidos
- Cálculo de prazo de entrega
- Identificação de atrasos

---

## 4. Tabela `order_items`

### Descrição

Tabela com os itens de cada pedido. Um pedido pode possuir um ou mais itens.

### Chave composta sugerida

| Coluna | Descrição |
|---|---|
| `order_id` | Identificador do pedido |
| `order_item_id` | Sequência do item dentro do pedido |

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `order_id` | string | Identificador do pedido | Não nulo |
| `order_item_id` | integer | Número sequencial do item | Não nulo |
| `product_id` | string | Identificador do produto | Não nulo |
| `seller_id` | string | Identificador do vendedor | Não nulo |
| `shipping_limit_date` | datetime | Data limite para envio | Não nulo |
| `price` | decimal | Valor do item | Maior ou igual a zero |
| `freight_value` | decimal | Valor do frete | Maior ou igual a zero |

### Uso analítico

- Cálculo de faturamento
- Análise por produto
- Análise por vendedor
- Cálculo de frete
- Ranking de categorias e produtos

---

## 5. Tabela `customers`

### Descrição

Tabela com informações dos clientes e sua localização.

### Chave principal

| Coluna | Tipo esperado | Descrição |
|---|---|---|
| `customer_id` | string | Identificador do cliente no pedido |

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `customer_id` | string | Identificador do cliente no pedido | Não nulo e único |
| `customer_unique_id` | string | Identificador único do cliente | Não nulo |
| `customer_zip_code_prefix` | integer | Prefixo do CEP do cliente | Não nulo |
| `customer_city` | string | Cidade do cliente | Não nulo |
| `customer_state` | string | Estado do cliente | Não nulo |

### Uso analítico

- Análise geográfica de clientes
- Pedidos por estado
- Pedidos por cidade
- Identificação de clientes recorrentes

---

## 6. Tabela `products`

### Descrição

Tabela com informações cadastrais dos produtos.

### Chave principal

| Coluna | Tipo esperado | Descrição |
|---|---|---|
| `product_id` | string | Identificador único do produto |

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `product_id` | string | Identificador do produto | Não nulo e único |
| `product_category_name` | string | Categoria do produto | Monitorar nulos |
| `product_name_lenght` | integer | Tamanho do nome do produto | Pode ser nulo |
| `product_description_lenght` | integer | Tamanho da descrição do produto | Pode ser nulo |
| `product_photos_qty` | integer | Quantidade de fotos do produto | Pode ser nulo |
| `product_weight_g` | decimal | Peso do produto em gramas | Maior ou igual a zero |
| `product_length_cm` | decimal | Comprimento em cm | Maior ou igual a zero |
| `product_height_cm` | decimal | Altura em cm | Maior ou igual a zero |
| `product_width_cm` | decimal | Largura em cm | Maior ou igual a zero |

### Uso analítico

- Análise por categoria
- Performance de produtos
- Relação entre características físicas e frete
- Produtos mais vendidos

---

## 7. Tabela `payments`

### Descrição

Tabela com informações de pagamento dos pedidos.

### Chave sugerida

A tabela pode possuir múltiplos pagamentos por pedido. Portanto, a chave analítica sugerida pode ser composta por:

| Coluna | Descrição |
|---|---|
| `order_id` | Identificador do pedido |
| `payment_sequential` | Sequência do pagamento |

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `order_id` | string | Identificador do pedido | Não nulo |
| `payment_sequential` | integer | Sequência do pagamento | Não nulo |
| `payment_type` | string | Tipo de pagamento | Deve estar em lista controlada |
| `payment_installments` | integer | Quantidade de parcelas | Maior ou igual a zero |
| `payment_value` | decimal | Valor pago | Maior ou igual a zero |

### Uso analítico

- Análise de faturamento
- Métodos de pagamento mais utilizados
- Valor médio pago
- Parcelamento médio
- Comparação entre boleto, cartão, voucher e débito

---

## 8. Tabela `reviews`

### Descrição

Tabela com avaliações dos clientes sobre os pedidos.

### Chave principal

| Coluna | Tipo esperado | Descrição |
|---|---|---|
| `review_id` | string | Identificador da avaliação |

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `review_id` | string | Identificador da avaliação | Não nulo |
| `order_id` | string | Identificador do pedido avaliado | Não nulo |
| `review_score` | integer | Nota da avaliação de 1 a 5 | Entre 1 e 5 |
| `review_comment_title` | string | Título do comentário | Pode ser nulo |
| `review_comment_message` | string | Texto do comentário | Pode ser nulo |
| `review_creation_date` | datetime | Data de criação da avaliação | Não nulo |
| `review_answer_timestamp` | datetime | Data da resposta da avaliação | Pode ser nulo |

### Uso analítico

- Análise de satisfação dos clientes
- Score médio por categoria
- Score médio por vendedor
- Relação entre atraso e avaliação
- Uso de IA para sentimento e classificação de reclamações

---

## 9. Tabela `sellers`

### Descrição

Tabela com informações dos vendedores.

### Chave principal

| Coluna | Tipo esperado | Descrição |
|---|---|---|
| `seller_id` | string | Identificador único do vendedor |

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `seller_id` | string | Identificador do vendedor | Não nulo e único |
| `seller_zip_code_prefix` | integer | Prefixo do CEP do vendedor | Não nulo |
| `seller_city` | string | Cidade do vendedor | Não nulo |
| `seller_state` | string | Estado do vendedor | Não nulo |

### Uso analítico

- Análise de performance por vendedor
- Vendas por estado do vendedor
- Atrasos por vendedor
- Faturamento por vendedor

---

## 10. Tabela `geolocation`

### Descrição

Tabela com dados geográficos por prefixo de CEP.

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `geolocation_zip_code_prefix` | integer | Prefixo do CEP | Não nulo |
| `geolocation_lat` | decimal | Latitude | Deve estar entre -90 e 90 |
| `geolocation_lng` | decimal | Longitude | Deve estar entre -180 e 180 |
| `geolocation_city` | string | Cidade | Não nulo |
| `geolocation_state` | string | Estado | Não nulo |

### Uso analítico

- Análise geográfica
- Enriquecimento de clientes
- Enriquecimento de vendedores
- Visualizações em mapa

---

## 11. Tabela `category_translation`

### Descrição

Tabela auxiliar para tradução das categorias de produtos do português para o inglês.

### Colunas

| Coluna | Tipo esperado | Descrição | Regra de qualidade |
|---|---|---|---|
| `product_category_name` | string | Nome original da categoria | Não nulo |
| `product_category_name_english` | string | Nome da categoria em inglês | Não nulo |

### Uso analítico

- Padronização de categorias
- Melhor entendimento em dashboards
- Enriquecimento da dimensão produto

---

## 12. Relacionamentos entre Tabelas

```text
customers.customer_id
        |
        v
orders.customer_id

orders.order_id
        |
        +----------------> order_items.order_id
        |
        +----------------> payments.order_id
        |
        +----------------> reviews.order_id

order_items.product_id
        |
        v
products.product_id

order_items.seller_id
        |
        v
sellers.seller_id

products.product_category_name
        |
        v
category_translation.product_category_name
```

---

## 13. Entidades para Modelagem Dimensional

A partir das tabelas originais, serão criadas as seguintes entidades analíticas:

### Dimensões

| Dimensão | Origem |
|---|---|
| `dim_cliente` | `customers` |
| `dim_produto` | `products` + `category_translation` |
| `dim_vendedor` | `sellers` |
| `dim_tempo` | Datas da tabela `orders` |

### Fatos

| Fato | Origem |
|---|---|
| `fato_pedidos` | `orders` + `order_items` |
| `fato_pagamentos` | `payments` |
| `fato_reviews` | `reviews` + features de IA |
| `fato_entregas` | `orders` |

---

## 14. Regras de Negócio Importantes

### 14.1 Faturamento

O faturamento será calculado a partir da soma do campo:

```text
order_items.price
```

Também poderá ser analisado o valor pago com base em:

```text
payments.payment_value
```

### 14.2 Frete

O valor de frete será calculado a partir da soma do campo:

```text
order_items.freight_value
```

### 14.3 Entrega em atraso

Um pedido será considerado atrasado quando:

```text
order_delivered_customer_date > order_estimated_delivery_date
```

### 14.4 Tempo de entrega

O tempo de entrega será calculado como:

```text
order_delivered_customer_date - order_purchase_timestamp
```

### 14.5 Score de satisfação

O score de satisfação será calculado a partir do campo:

```text
review_score
```

### 14.6 Review negativo

Um review será considerado negativo quando:

```text
review_score <= 2
```

### 14.7 Review positivo

Um review será considerado positivo quando:

```text
review_score >= 4
```

---

## 15. Observações para Catalogação na Dadosfera

Na catalogação dos datasets na Dadosfera, devem ser documentados:

- descrição da tabela;
- finalidade de negócio;
- origem dos dados;
- camada do Data Lake;
- chave principal;
- chaves estrangeiras;
- regras de qualidade;
- periodicidade de atualização;
- responsáveis;
- sensibilidade dos dados;
- campos críticos para análise.

---

## 16. Conclusão

Este dicionário de dados serve como base para a catalogação dos ativos na Dadosfera, criação das regras de Data Quality, construção da modelagem dimensional e desenvolvimento das análises de negócio.

A documentação dos dados aumenta a governança, facilita o entendimento pelos usuários de negócio e reduz o tempo necessário para transformar dados brutos em valor analítico.