-- ============================================================
-- Tabela: PUBLIC.SILVER_PAYMENTS_ENRICHED
-- Camada: Silver
-- Origem: PUBLIC.BRONZE_PAYMENTS
-- Objetivo: Padronizar e classificar pagamentos dos pedidos
-- ============================================================

CREATE OR REPLACE TABLE PUBLIC.SILVER_PAYMENTS_ENRICHED AS
SELECT
    ORDER_ID,
    PAYMENT_SEQUENTIAL,
    PAYMENT_TYPE,
    PAYMENT_INSTALLMENTS,
    PAYMENT_VALUE,

    CASE
        WHEN PAYMENT_TYPE = 'credit_card' THEN 'Cartão de Crédito'
        WHEN PAYMENT_TYPE = 'boleto' THEN 'Boleto'
        WHEN PAYMENT_TYPE = 'voucher' THEN 'Voucher'
        WHEN PAYMENT_TYPE = 'debit_card' THEN 'Cartão de Débito'
        WHEN PAYMENT_TYPE = 'not_defined' THEN 'Não Definido'
        ELSE 'Outros'
    END AS PAYMENT_TYPE_DESCRIPTION,

    CASE
        WHEN PAYMENT_INSTALLMENTS IS NULL THEN 'Não informado'
        WHEN PAYMENT_INSTALLMENTS <= 1 THEN 'À vista'
        WHEN PAYMENT_INSTALLMENTS BETWEEN 2 AND 3 THEN '2 a 3 parcelas'
        WHEN PAYMENT_INSTALLMENTS BETWEEN 4 AND 6 THEN '4 a 6 parcelas'
        WHEN PAYMENT_INSTALLMENTS BETWEEN 7 AND 12 THEN '7 a 12 parcelas'
        ELSE 'Acima de 12 parcelas'
    END AS INSTALLMENT_RANGE,

    CASE
        WHEN PAYMENT_VALUE IS NULL THEN 'payment_missing'
        WHEN PAYMENT_VALUE = 0 THEN 'zero_payment'
        WHEN PAYMENT_VALUE > 0 THEN 'valid_payment'
        ELSE 'invalid_payment'
    END AS PAYMENT_VALUE_STATUS,

    CURRENT_TIMESTAMP() AS SILVER_CREATED_AT

FROM PUBLIC.BRONZE_PAYMENTS;