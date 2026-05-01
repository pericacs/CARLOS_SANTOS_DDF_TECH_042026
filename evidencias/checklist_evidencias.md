# Checklist de Evidências - Case Técnico Dadosfera

## 1. Objetivo

Este documento centraliza todas as evidências necessárias para a entrega final do case técnico da Dadosfera.

As evidências devem comprovar que os dados foram carregados, catalogados, validados, modelados, analisados e disponibilizados para consumo.

---

## 2. Evidências do Repositório GitHub

| Evidência | Status | Caminho / Link |
|---|---|---|
| Repositório criado com nome correto | Pendente | `CARLOS_SANTOS_DDF_TECH_042026` |
| README principal completo | Pendente | `README.md` |
| Estrutura de pastas criada | Pendente | Raiz do projeto |
| Dicionário de dados criado | Pendente | `data/dicionario_dados_olist.md` |
| Instruções de download criadas | Pendente | `data/instrucoes_download_olist.md` |
| Script de exploração criado | Pendente | `notebooks/01_exploracao_olist.py` |
| Script de Data Quality criado | Pendente | `data_quality/great_expectations_olist.py` |
| SQLs da camada Gold criados | Pendente | `sql/gold/` |
| Data App criado | Pendente | `streamlit_app/app.py` |
| Roteiro do vídeo criado | Pendente | `apresentacao/roteiro_video.md` |

---

## 3. Evidências dos Dados Brutos

| Evidência | Status | Caminho |
|---|---|---|
| Arquivo `olist_orders_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `olist_order_items_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `olist_customers_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `olist_products_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `olist_order_payments_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `olist_order_reviews_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `olist_sellers_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `olist_geolocation_dataset.csv` disponível localmente | Pendente | `data/raw/` |
| Arquivo `product_category_name_translation.csv` disponível localmente | Pendente | `data/raw/` |

---

## 4. Evidências da Exploração Inicial

| Evidência | Status | Caminho |
|---|---|---|
| Script de exploração executado com sucesso | Pendente | `notebooks/01_exploracao_olist.py` |
| Relatório de exploração gerado | Pendente | `data_quality/reports/resumo_exploracao_olist.md` |
| Contagem de registros validada | Pendente | `data_quality/reports/resumo_exploracao_olist.md` |
| Volume mínimo de 100.000 registros comprovado | Pendente | `data_quality/reports/resumo_exploracao_olist.md` |

---

## 5. Evidências de Data Quality

| Evidência | Status | Caminho |
|---|---|---|
| Script de Great Expectations executado | Concluído  | `data_quality/great_expectations_olist.py` |
| Relatório Markdown gerado | Concluído  | `data_quality/reports/relatorio_data_quality_olist.md` |
| Resultado JSON gerado | Concluído  | `data_quality/reports/resultado_data_quality_olist.json` |
| Regras de qualidade documentadas | Concluído  | `README.md` e `data/dicionario_dados_olist.md` |
| Prints do relatório salvos | Pendente | `evidencias/data_quality/` |

Sugestões de prints:

```text
evidencias/data_quality/relatorio_data_quality_resumo.png
evidencias/data_quality/validacoes_great_expectations.png
```

---

## 6. Evidências da Dadosfera

| Evidência | Status | Link / Caminho |
|---|---|---|
| Dataset `orders` carregado | Concluído | `PUBLIC.RAW_ORDERS` |
| Dataset `order_items` carregado | Concluído | `PUBLIC.RAW_ORDER_ITEMS` |
| Dataset `customers` carregado | Concluído | `PUBLIC.RAW_CUSTOMERS` |
| Dataset `products` carregado | Concluído | `PUBLIC.RAW_PRODUCTS` |
| Dataset `payments` carregado | Concluído | `PUBLIC.RAW_PAYMENTS` |
| Dataset `reviews` carregado | Concluído | `PUBLIC.RAW_REVIEWS` |
| Dataset `sellers` carregado | Concluído | `PUBLIC.RAW_SELLERS` |
| Dataset `geolocation` carregado | Concluído | `PUBLIC.RAW_GEOLOCATION` |
| Dataset `category_translation` carregado | Concluído | `PUBLIC.RAW_CATEGORY_TRANSLATION` |
| Datasets organizados em zona/camada | Concluído | Prefixo `RAW_` no schema `PUBLIC` |
| Datasets catalogados | Concluído | Descrições preenchidas no Catálogo da Dadosfera |

Sugestões de prints:

```text
evidencias/dadosfera/datasets/orders_dataset.png
evidencias/dadosfera/datasets/order_items_dataset.png
evidencias/dadosfera/catalogo/catalogo_orders.png
evidencias/dadosfera/catalogo/catalogo_gold.png
```

---

## 7. Evidências da Modelagem Gold

| Evidência | Status | Caminho |
|---|---|---|
| SQL `dim_cliente` criado | Pendente | `sql/gold/dim_cliente.sql` |
| SQL `dim_produto` criado | Pendente | `sql/gold/dim_produto.sql` |
| SQL `dim_vendedor` criado | Pendente | `sql/gold/dim_vendedor.sql` |
| SQL `dim_tempo` criado | Pendente | `sql/gold/dim_tempo.sql` |
| SQL `fato_pedidos` criado | Pendente | `sql/gold/fato_pedidos.sql` |
| SQL `fato_pagamentos` criado | Pendente | `sql/gold/fato_pagamentos.sql` |
| SQL `fato_reviews` criado | Pendente | `sql/gold/fato_reviews.sql` |
| View comercial criada | Pendente | `sql/gold/vw_ecommerce_performance_comercial.sql` |
| View experiência cliente criada | Pendente | `sql/gold/vw_ecommerce_experiencia_cliente.sql` |

---

## 8. Evidências do Dashboard

| Evidência | Status | Link / Caminho |
|---|---|---|
| Dashboard criado na Dadosfera | Pendente | Link Dadosfera |
| Pelo menos 5 visualizações criadas | Pendente | Link Dadosfera |
| Faturamento mensal criado | Pendente | Print |
| Pedidos por estado criado | Pendente | Print |
| Faturamento por categoria criado | Pendente | Print |
| Percentual de entregas atrasadas criado | Pendente | Print |
| Nota média por categoria criada | Pendente | Print |
| Dashboard documentado | Pendente | `apresentacao/planejamento_dashboard.md` |

Sugestões de prints:

```text
evidencias/dashboard/dashboard_visao_executiva.png
evidencias/dashboard/dashboard_logistica.png
evidencias/dashboard/dashboard_experiencia_cliente.png
```

---

## 9. Evidências do Data App

| Evidência | Status | Caminho |
|---|---|---|
| App criado em Streamlit | Pendente | `streamlit_app/app.py` |
| Requirements criados | Pendente | `streamlit_app/requirements.txt` |
| README do app criado | Pendente | `streamlit_app/README.md` |
| App executado localmente | Pendente | `http://localhost:8501` |
| Prints do app salvos | Pendente | `evidencias/data_app/` |

Sugestões de prints:

```text
evidencias/data_app/data_app_visao_geral.png
evidencias/data_app/data_app_graficos.png
evidencias/data_app/data_app_reviews.png
```

---

## 10. Evidências do Vídeo

| Evidência | Status | Link / Caminho |
|---|---|---|
| Roteiro criado | Pendente | `apresentacao/roteiro_video.md` |
| Vídeo gravado | Pendente | Arquivo local |
| Vídeo publicado como não listado | Pendente | YouTube |
| Link do vídeo adicionado ao README | Pendente | `README.md` |
| Link do vídeo adicionado neste checklist | Pendente | Campo abaixo |

Link do vídeo:

```text
Pendente
```

---

## 11. Checklist Final Antes do Envio

Antes de enviar o case, validar:

- [ ] Repositório GitHub público ou acessível
- [ ] README principal atualizado
- [ ] Link do vídeo incluído no README
- [ ] Links da Dadosfera incluídos no README
- [ ] Prints salvos na pasta `evidencias/`
- [X] Data Quality executado
- [X] Relatório de Data Quality versionado
- [ ] SQLs da modelagem versionados
- [ ] Data App versionado
- [ ] Dashboard criado com pelo menos 5 visualizações
- [ ] Dicionário de dados criado
- [ ] Commits enviados para o GitHub
- [ ] Nenhum CSV pesado enviado ao GitHub
- [ ] `.gitignore` funcionando corretamente

---

## 12. Conclusão

Este checklist será utilizado para garantir que a entrega final esteja completa, rastreável e aderente aos critérios do case técnico.

A cada etapa concluída, o status deve ser atualizado de `Pendente` para `Concluído`.