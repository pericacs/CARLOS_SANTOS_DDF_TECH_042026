# Kanban do Projeto - Case Técnico Dadosfera

## 1. Objetivo

Este documento apresenta o controle Kanban do projeto desenvolvido para o case técnico da Dadosfera.

O objetivo é organizar as atividades por status, facilitar o acompanhamento da execução e garantir que os itens obrigatórios e diferenciais sejam entregues.

---

## 2. Legenda de Status

| Status | Descrição |
|---|---|
| Backlog | Atividade planejada, ainda não iniciada |
| Em andamento | Atividade em execução |
| Em revisão | Atividade concluída tecnicamente, aguardando validação |
| Concluído | Atividade finalizada e versionada no GitHub |

---

## 3. Kanban Geral

| Backlog | Em andamento | Em revisão | Concluído |
|---|---|---|---|
| Carga dos dados na Dadosfera | Execução dos scripts locais | Revisão do README principal | Estrutura do repositório |
| Catalogação dos datasets | Geração dos relatórios | Revisão dos SQLs Gold | README principal |
| Criação do dashboard na Dadosfera | Data Quality com Great Expectations | Revisão do Data App | Instruções de download da base |
| Prints dos datasets | Exploração inicial da base | Revisão do roteiro do vídeo | Dicionário de dados |
| Prints do catálogo |  |  | Modelagem Gold |
| Prints do dashboard |  |  | Views analíticas |
| Prints do Data App |  |  | Planejamento do dashboard |
| Publicação do vídeo no YouTube |  |  | Data App Streamlit |
| Atualização dos links no README |  |  | Roteiro do vídeo |
| Revisão final da entrega |  |  | Checklist de evidências |
|  |  |  | Planejamento Gantt |
|  |  |  | Riscos, custos, recursos e dependências |

---

## 4. Itens Obrigatórios do Case

| Item | Atividade | Status | Evidência Esperada |
|---|---|---|---|
| Integração de dados | Carregar base Olist com mais de 100 mil registros | Backlog | Link e print na Dadosfera |
| Exploração e catálogo | Organizar datasets em zonas e catalogar | Backlog | Prints do catálogo |
| Data Quality | Executar validações com Great Expectations | Em andamento | Relatório Markdown/JSON |
| Análise | Criar dashboard com 5+ visualizações | Backlog | Link e prints do dashboard |
| GitHub | Versionar documentação, scripts e evidências | Em andamento | Repositório atualizado |

---

## 5. Itens Diferenciais

| Item | Atividade | Status | Evidência Esperada |
|---|---|---|---|
| Planejamento | Gantt, riscos e Kanban | Concluído | Pasta `planejamento/` |
| Modelagem | Criar modelo Kimball | Concluído | Pasta `sql/gold/` |
| Data App | Criar app em Streamlit | Concluído | Pasta `streamlit_app/` |
| Apresentação | Criar roteiro de vídeo | Concluído | `apresentacao/roteiro_video.md` |
| Evidências | Criar checklist de prints e links | Concluído | `evidencias/checklist_evidencias.md` |
| IA/LLM | Enriquecer reviews com features inteligentes | Backlog | Script/notebook de features |

---

## 6. Próximas Atividades Prioritárias

As próximas atividades com maior prioridade são:

1. Baixar a base Olist.
2. Colocar os arquivos CSV em `data/raw/`.
3. Executar o script de exploração inicial.
4. Executar o script de Data Quality.
5. Salvar os relatórios gerados.
6. Carregar os datasets na Dadosfera.
7. Catalogar os ativos na Dadosfera.
8. Criar o dashboard.
9. Salvar prints das evidências.
10. Atualizar o README com links e prints.

---

## 7. Controle de Progresso

| Área | Status Atual |
|---|---|
| Documentação | Avançado |
| Planejamento | Avançado |
| Exploração de Dados | Em andamento |
| Data Quality | Em andamento |
| Modelagem | Avançado |
| Dadosfera | Pendente |
| Dashboard | Pendente |
| Data App | Criado |
| Evidências | Pendente |
| Vídeo | Pendente |

---

## 8. Checklist Operacional

### Antes de executar localmente

- [ ] Ambiente Python criado
- [ ] Dependências instaladas
- [ ] Base Olist baixada
- [ ] CSVs colocados em `data/raw/`
- [ ] `.gitignore` validado

### Antes de carregar na Dadosfera

- [ ] CSVs conferidos
- [ ] Volume de registros validado
- [ ] Dicionário de dados criado
- [ ] Regras de qualidade definidas
- [ ] Nome das tabelas definido

### Antes de criar dashboard

- [ ] Dados carregados na Dadosfera
- [ ] Tabelas catalogadas
- [ ] SQLs Gold ajustados ao ambiente
- [ ] Views analíticas criadas
- [ ] Perguntas de negócio definidas

### Antes da entrega final

- [ ] README atualizado
- [ ] Links da Dadosfera adicionados
- [ ] Prints adicionados em `evidencias/`
- [ ] Relatórios versionados
- [ ] Vídeo publicado como não listado
- [ ] Link do vídeo adicionado
- [ ] Último `git push` realizado

---

## 9. Conclusão

O Kanban permite acompanhar o andamento do case de forma simples e visual.

Ele complementa o cronograma Gantt e o documento de riscos, ajudando a controlar as atividades pendentes, em andamento e concluídas até a entrega final.