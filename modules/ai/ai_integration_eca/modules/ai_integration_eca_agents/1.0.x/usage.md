AI Integration - ECA: Agents adds an `ai_agents` "ECA Agent" plus an *Ask AI* form so an LLM can answer questions about, and build/modify, ECA models and their available components (events, conditions, actions).

---

The submodule registers an AI agent plugin `eca` (`src/Plugin/AiAgent/Eca.php`, `#[AiAgent]`) with a matching validation plugin `eca_validation` (`#[AiAgentValidation]`). The agent turns natural-language requests into ECA model changes by consulting a **DataProvider** service that enumerates the site's available ECA components and models (with `teaser`/`full` view modes), a **ModelMapper** and **EcaRepository** that map between ECA config entities and a normalized DTO/typed-data model (DataType plugins `EcaModel`, `EcaGateway`, `EcaPlugin`, `EcaSuccessor` with a JSON schema in `src/Schema/Eca.php`), and a `DataDefinitionNormalizer` (decorating schemata's JSON-schema normalizer). An **Ask AI** form (`AskAiForm`) is exposed at `/api/ai-eca-agents/ask-ai` (route `ai_integration_eca_agents.ask_ai`, permission **`administer eca`**, `_admin_route`) and as a local action on the ECA collection page; it runs the agent in a Batch (determine task → execute) against an optional `model-id` query arg. A `hook_form_bpmn_io_modeller_alter` (`FormHooks`) integrates with the BPMN.iO ECA modeller. A Drush/console command `ai-agents-eca:debug:data` dumps the data provider output. Depends on `ai_integration_eca`, `ai_agents`, `eca_ui`, `schemata_json_schema`, `token`. All entry points are gated by ECA admin access.

---

- Ask an LLM in plain language to build a new ECA model for you.
- Ask the AI to modify or extend an existing ECA model (passing its `model-id`).
- Have the AI answer questions about which ECA events/conditions/actions are available.
- Let the agent map an ECA model to/from a structured JSON representation.
- Use the *Ask AI* local action on the ECA models list to kick off a prompt.
- Integrate AI assistance directly into the BPMN.iO ECA modeller UI.
- Generate ECA components from a described automation goal.
- Validate AI-produced ECA models via the `eca_validation` plugin before applying.
- Debug what component/model data the agent sees with `drush ai-agents-eca:debug:data`.
- Inspect the agent's data in full vs teaser view mode for prompt-size tuning.
- Provide a taskable AI agent for ECA within the broader `ai_agents` framework.
- Answer "how do I model X in ECA?" using site-specific available plugins.
- Prototype workflows conversationally, then refine them in the modeller.
- Expose ECA authoring to less technical admins through natural language.
- Restrict all AI-ECA authoring to users with `administer eca`.
