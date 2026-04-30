-- ============================================================
-- Tabela: fato_pagamentos
-- Camada: Gold
-- Objetivo: Fato de pagamentos dos pedidos
-- Origem: payments + orders + dim_tempo
-- ============================================================

CREATE OR REPLACE TABLE gold.fato_pagamentos AS
SELECT
    p.order_id,
    dt.sk_tempo AS sk_tempo_compra,

    p.payment_sequential,
    p.payment_type,
    p.payment_installments,
    p.payment_value,

    CASE
        WHEN p.payment_type = 'credit_card' THEN 'Cartão de Crédito'
        WHEN p.payment_type = 'boleto' THEN 'Boleto'
        WHEN p.payment_type = 'voucher' THEN 'Voucher'
        WHEN p.payment_type = 'debit_card' THEN 'Cartão de Débito'
        WHEN p.payment_type = 'not_defined' THEN 'Não Definido'
        ELSE 'Outros'
    END AS payment_type_description,

    CASE
        WHEN p.payment_installments <= 1 THEN 'À vista'
        WHEN p.payment_installments BETWEEN 2 AND 3 THEN '2 a 3 parcelas'
        WHEN p.payment_installments BETWEEN 4 AND 6 THEN '4 a 6 parcelas'
        WHEN p.payment_installments BETWEEN 7 AND 12 THEN '7 a 12 parcelas'
        ELSE 'Acima de 12 parcelas'
    END AS faixa_parcelamento

FROM silver.payments p

LEFT JOIN silver.orders o
    ON p.order_id = o.order_id

LEFT JOIN gold.dim_tempo dt
    ON CAST(o.order_purchase_timestamp AS DATE) = dt.data

WHERE p.order_id IS NOT NULL;