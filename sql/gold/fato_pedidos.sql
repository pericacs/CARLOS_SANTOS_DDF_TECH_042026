-- ============================================================
-- Tabela: fato_pedidos
-- Camada: Gold
-- Objetivo: Fato principal de pedidos, vendas, frete e entrega
-- Origem: orders + order_items + dim_cliente + dim_produto + dim_vendedor
-- ============================================================

CREATE OR REPLACE TABLE gold.fato_pedidos AS
WITH itens AS (
    SELECT
        order_id,
        product_id,
        seller_id,
        COUNT(*) AS quantidade_itens,
        SUM(price) AS valor_produtos,
        SUM(freight_value) AS valor_frete,
        SUM(price + freight_value) AS valor_total_pedido
    FROM silver.order_items
    GROUP BY
        order_id,
        product_id,
        seller_id
),

pedidos AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        CAST(order_purchase_timestamp AS DATE) AS data_compra,
        CAST(order_approved_at AS DATE) AS data_aprovacao,
        CAST(order_delivered_carrier_date AS DATE) AS data_envio_transportadora,
        CAST(order_delivered_customer_date AS DATE) AS data_entrega_cliente,
        CAST(order_estimated_delivery_date AS DATE) AS data_estimada_entrega
    FROM silver.orders
)

SELECT
    p.order_id,
    dc.sk_cliente,
    dp.sk_produto,
    dv.sk_vendedor,
    dt.sk_tempo AS sk_tempo_compra,

    p.order_status,

    p.data_compra,
    p.data_aprovacao,
    p.data_envio_transportadora,
    p.data_entrega_cliente,
    p.data_estimada_entrega,

    i.quantidade_itens,
    i.valor_produtos,
    i.valor_frete,
    i.valor_total_pedido,

    CASE
        WHEN p.data_entrega_cliente IS NULL THEN NULL
        WHEN p.data_estimada_entrega IS NULL THEN NULL
        WHEN p.data_entrega_cliente > p.data_estimada_entrega THEN 1
        ELSE 0
    END AS flag_entrega_atrasada,

    CASE
        WHEN p.data_entrega_cliente IS NULL THEN NULL
        ELSE DATE_DIFF('day', p.data_compra, p.data_entrega_cliente)
    END AS dias_ate_entrega,

    CASE
        WHEN p.data_entrega_cliente IS NULL THEN NULL
        ELSE DATE_DIFF('day', p.data_estimada_entrega, p.data_entrega_cliente)
    END AS dias_atraso

FROM pedidos p
INNER JOIN itens i
    ON p.order_id = i.order_id

LEFT JOIN gold.dim_cliente dc
    ON p.customer_id = dc.customer_id

LEFT JOIN gold.dim_produto dp
    ON i.product_id = dp.product_id

LEFT JOIN gold.dim_vendedor dv
    ON i.seller_id = dv.seller_id

LEFT JOIN gold.dim_tempo dt
    ON p.data_compra = dt.data;