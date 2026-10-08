# The ECA agent, Ask AI form, and services

## AI agent plugin `eca`

`src/Plugin/AiAgent/Eca.php` (`#[AiAgent(id:'eca')]`, extends `ai_agents`' `AiAgentBase`). It
answers questions about, and produces changes to, ECA models. It pulls the site's available ECA
components + existing models from the DataProvider, builds a normalized DTO/typed-data model, and
returns ECA config the framework can apply. Paired validation plugin `eca_validation`
(`#[AiAgentValidation(id:'eca_validation')]`) JSON-decodes and validates the LLM output (raising
`AgentRetryableValidationException` to re-prompt on invalid output). Prompt templates ship in
`prompts/eca/*.yml` (`answerQuestion`, `buildModel`, `determineTask`).

## Ask AI form / route

- Route `ai_integration_eca_agents.ask_ai` → path `/api/ai-eca-agents/ask-ai`, `_form` =
  `Drupal\ai_integration_eca_agents\Form\AskAiForm`, requirement `_permission: 'administer eca'`,
  `_admin_route: true`.
- Also surfaced as a local **action** (`Ask AI`) on `entity.eca.collection`
  (`AiEcaAgentsDialogLocalAction`).
- `AskAiForm`: a `question` textarea; reads `destination` and `model-id` from the query string.
  On submit it builds a Batch — `initProcess` → `determineTask($question, $modelId)` →
  `executeTask` — so the agent first decides solvability/what task to run, then executes it,
  redirecting to `destination` (default the ECA collection) when done.

## Services

| Service id | Class | Role |
|---|---|---|
| `ai_integration_eca_agents.services.data_provider` | `Services\DataProvider\DataProvider` | Enumerates available ECA events/conditions/actions (`getComponents()`) and existing models (`getModels()`); `setViewMode(DataViewModeEnum::Teaser|Full)` controls verbosity/prompt size. |
| `ai_integration_eca_agents.services.model_mapper` | `Services\ModelMapper\ModelMapper` | Maps ECA config entities ↔ normalized typed-data model. |
| `ai_integration_eca_agents.services.eca_repository` | `Services\EcaRepository\EcaRepository` | Loads/saves ECA entities as the DTO the agent works with. |
| `serializer.normalizer.data_definition.schema_json_ai_integration_eca_agents.json` | `Normalizer\json\DataDefinitionNormalizer` | Decorates schemata's JSON-schema normalizer for final typed-data items. |

DataType plugins `EcaModel`, `EcaGateway`, `EcaPlugin`, `EcaSuccessor` (+ their `*Definition`
classes) model the ECA structure; JSON schema in `src/Schema/Eca.php`; a
`SuccessorsAreValidConstraint`/validator enforces valid successor references.

Access: everything above requires `administer eca` — this is an ECA-admin authoring tool, not a
public endpoint.
