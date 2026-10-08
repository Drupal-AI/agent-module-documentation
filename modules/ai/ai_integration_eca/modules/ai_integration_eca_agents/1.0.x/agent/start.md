# AI Integration - ECA: Agents — agent index

Adds an `ai_agents` **ECA Agent** (`eca`) + validation (`eca_validation`) and an **Ask AI** form so
an LLM can answer questions about and build/modify ECA models. All entry points gated by
`administer eca`. Parent: `ai_integration_eca`.

- **The agent, Ask AI route/form, the DataProvider/ModelMapper/EcaRepository services, DataTypes** →
  [api/agent.md](api/agent.md)
- **The `ai-agents-eca:debug:data` console command** → [drush/commands.md](drush/commands.md)

Key facts:
- AI agent plugin `eca` (`src/Plugin/AiAgent/Eca.php`), validation plugin `eca_validation`.
- **Ask AI**: route `ai_integration_eca_agents.ask_ai` → `/api/ai-eca-agents/ask-ai`
  (`_form` `AskAiForm`, permission `administer eca`, `_admin_route: true`); also a local action on
  `entity.eca.collection`. Runs a Batch (init → determineTask → executeTask); optional `model-id`
  query arg targets an existing model.
- Services: `..._agents.services.data_provider` (components + models, `teaser`/`full` view modes),
  `...model_mapper`, `...eca_repository`; DataType plugins `EcaModel`/`EcaGateway`/`EcaPlugin`/
  `EcaSuccessor` (JSON schema in `src/Schema/Eca.php`); `DataDefinitionNormalizer` decorates
  schemata's normalizer.
- BPMN.iO modeller integration via `hook_form_bpmn_io_modeller_alter` (`Hook/FormHooks`).
- No config schema/permissions of its own beyond relying on `administer eca`.
