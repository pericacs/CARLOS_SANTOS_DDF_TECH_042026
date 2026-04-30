# Streamlit Data App - E-commerce Olist Analytics

## 1. Objetivo

Este Data App foi criado para permitir a exploração interativa da base Olist utilizada no case técnico da Dadosfera.

O app permite analisar indicadores comerciais, logísticos e de experiência do cliente a partir dos arquivos CSV da base.

---

## 2. Funcionalidades

O app apresenta:

- total de pedidos;
- faturamento total;
- ticket médio;
- percentual de entregas atrasadas;
- nota média dos reviews;
- evolução do faturamento mensal;
- pedidos por estado;
- faturamento por categoria;
- categorias com pior nota média;
- relação entre atraso de entrega e classificação do review;
- amostra de comentários dos clientes.

---

## 3. Filtros Disponíveis

O app possui filtros laterais para:

- estado do cliente;
- categoria do produto;
- status do pedido.

---

## 4. Pré-requisitos

Os arquivos CSV da base Olist devem estar disponíveis na pasta:

```text
data/raw/
```

Arquivos esperados:

```text
olist_orders_dataset.csv
olist_order_items_dataset.csv
olist_customers_dataset.csv
olist_products_dataset.csv
olist_order_reviews_dataset.csv
olist_order_payments_dataset.csv
olist_sellers_dataset.csv
product_category_name_translation.csv
```

---

## 5. Instalação

A partir da raiz do projeto, executar:

```bash
pip install -r streamlit_app/requirements.txt
```

---

## 6. Execução

A partir da raiz do projeto, executar:

```bash
streamlit run streamlit_app/app.py
```

---

## 7. Evidências

Após executar o app, salvar prints em:

```text
evidencias/data_app/
```

Sugestões de prints:

```text
evidencias/data_app/data_app_visao_geral.png
evidencias/data_app/data_app_filtros.png
evidencias/data_app/data_app_reviews.png
```

---

## 8. Relação com o Case

Este Data App demonstra como os dados tratados podem ser disponibilizados para usuários de negócio em uma interface simples e interativa.

A aplicação complementa o dashboard da Dadosfera e reforça a entrega de valor a partir dos dados.