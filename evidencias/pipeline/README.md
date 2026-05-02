# Evidências de Pipeline e Camadas

## 1. Objetivo

Esta pasta contém evidências da criação e validação das camadas Bronze, Silver e Gold na Dadosfera.

---

## 2. Arquitetura executada

```text
PUBLIC.TB__JIZIE8__PUBLIC__TB_* 
    ↓
PUBLIC.BRONZE_*
    ↓
PUBLIC.SILVER_*_ENRICHED
    ↓
PUBLIC.GOLD_*
    ↓
PUBLIC.GOLD_VW_*