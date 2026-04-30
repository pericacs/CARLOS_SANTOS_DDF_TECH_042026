-- ============================================================
-- View: vw_ecommerce_performance_comercial
-- Camada: Gold
-- Objetivo: Visão consolidada para dashboard comercial
-- Origem: fato_pedidos + dimensões
-- ============================================================

CREATE OR REPLACE VIEW gold.vw_ecommerce_performance_comercial AS
SELECT
    ft.data AS data_compra,
    ft.ano,
    ft.mes,
    ft.trimestre,

    dc.customer_state AS estado_cliente,
    dc.customer_city AS cidade_cliente,

    dp.product_category_name,
    dp.product_category_name_english,

    dv.seller_state AS estado_vendedor,
    dv.seller_city AS cidade_vendedor,

    fp.order_status,

    COUNT(DISTINCT fp.order_id) AS total_pedidos,
    SUM(fp.quantidade_itens) AS total_itens,
    SUM(fp.valor_produtos) AS faturamento_produtos,
    SUM(fp.valor_frete) AS valor_total_frete,
    SUM(fp.valor_total_pedido) AS faturamento_total,

    AVG(fp.valor_total_pedido) AS ticket_medio,
    AVG(fp.dias_ate_entrega) AS media_dias_entrega,
    AVG(fp.dias_atraso) AS media_dias_atraso,

    SUM(fp.flag_entrega_atrasada) AS total_entregas_atrasadas,

    CAST(SUM(fp.flag_entrega_atrasada) AS DOUBLE)
        / NULLIF(COUNT(DISTINCT fp.order_id), 0) AS percentual_entregas_atrasadas

FROM gold.fato_pedidos fp

LEFT JOIN gold.dim_tempo ft
    ON fp.sk_tempo_compra = ft.sk_tempo

LEFT JOIN gold.dim_cliente dc
    ON fp.sk_cliente = dc.sk_cliente

LEFT JOIN gold.dim_produto dp
    ON fp.sk_produto = dp.sk_produto

LEFT JOIN gold.dim_vendedor dv
    ON fp.sk_vendedor = dv.sk_vendedor

GROUP BY
    ft.data,
    ft.ano,
    ft.mes,
    ft.trimestre,
    dc.customer_state,
    dc.customer_city,
    dp.product_category_name,
    dp.product_category_name_english,
    dv.seller_state,
    dv.seller_city,
    fp.order_status;