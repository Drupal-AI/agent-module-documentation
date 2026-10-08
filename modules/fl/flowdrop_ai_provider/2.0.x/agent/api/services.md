# Services, JSON API routes & controllers

## Services (`flowdrop_ai_provider.services.yml`)

### `flowdrop_ai_provider.model_service` — `Service\AiModelService`
Args: `logger.factory`, `ai.provider`, `cache.default`. The model-discovery layer every processor uses.

- `getAvailableModels($operation_type = 'chat', array $capabilities = [])` /
  `getModelsForOperationType(...)` — iterates `ai.provider` definitions, keeps providers where
  `isUsable($op, $caps)`, returns `[$model_id => ['id','name','provider','operation_type']]`. Result is
  cached in-request and in `cache.default` (key `flowdrop_ai_provider.models.<op>:<hash>`, TTL 1h, tags
  `ai_provider_models`, `config:ai.settings`).
- `getDefaultModelForOperationType($op)`, `getModel($model_id, $op = '')`,
  `supportsOperationType()`, `getModelsByProvider()`, `hasProvidersForOperationType()`,
  `isOperationType($op)` (does `drupal/ai` register this operation type at all).
- `resolveModel($operation_type, $model_id = '')` — the single fallback entry point: explicit model wins;
  else operation-type default → underlying-type default → first model with the required capabilities.
  Understands **pseudo operation types** (`chat_with_tools`, `chat_with_image_vision`, …) via
  `getOperationTypeOptions()` / `resolveOperationType()`, resolving them to a real type + capability filter.

### `flowdrop_ai_provider.operation_availability` — `Service\AiOperationAvailability`
Args: `flowdrop_ai_provider.model_service`. `getOperationType($executorPlugin)` maps a namespaced
executor id to its AI operation type (`simple_chat`→`chat`; non-operation ids like `guardrails`/
`session_history` → `NULL` = needs no provider). `isExecutorAvailable()` = needs no provider, or a
provider is configured. Shared by the sidebar filter and the node-type form warning.

### `flowdrop_ai_provider.ai_prompt_resolver` — `Service\AiPromptResolver`
Args: `entity_type.manager`. `resolve($value, $variables = [])` returns literal text unchanged, or loads
an `ai_prompt` config entity for an `ai_prompt:<entity_id>` reference and substitutes `{var}` placeholders;
throws `\RuntimeException` when the referenced entity is missing. `isReference()` checks the prefix.

### `flowdrop_ai_provider.secure_file_loader` — `Service\SecureFileLoader`
Args: `http_client`, `file_system`. Hardened loader for processor file inputs.

- `loadFromFile($path)` — rejects `..`; resolves stream wrappers + `realpath()`; restricts to
  `public://`/`private://`/`temporary://` + system temp (`validateFileLocation`); 50 MB cap.
- `loadFromUrl($url)` — `validateUrl()` allows only `http`/`https`, resolves the host with
  `gethostbyname()` and blocks private/reserved ranges (`FILTER_FLAG_NO_PRIV_RANGE|NO_RES_RANGE`) and
  cloud-metadata endpoints (`169.254.169.254`, `metadata.google.internal`); then a **standard Guzzle
  request** (TLS verification left at its secure default — no `verify => false`), 30 s request / 10 s
  connect timeout, 50 MB response cap. Both methods throw on failure instead of returning `false`.

### Event subscribers & the reasoner override
- `flowdrop_ai_provider.node_list_filter_subscriber` (`EventSubscriber\NodeListFilterSubscriber`) —
  `KernelEvents::RESPONSE` prio 10; strips provider-less AI node types out of the
  `flowdrop_node_type.api.nodes[.category]` JSON before Dynamic Page Cache stores it (adds
  `config:ai.settings` cache tag).
- `flowdrop_ai_provider.ai_prompt_system_prompt_subscriber` (`EventSubscriber\AiPromptSystemPromptSubscriber`) —
  `ai_agents` `BuildSystemPromptEvent` prio 100; resolves an `ai_prompt:` reference in an agent's system prompt.
- `flowdrop_ai_provider.route_subscriber` (`Routing\AiSettingsRouteSubscriber`) — see [hooks](../hooks/hooks.md).
- `flowdrop.chat_reasoner` → `Service\Reasoning\ChatReasoner` — service override; see
  [../plugins/chat-processor.md](../plugins/chat-processor.md).

## JSON API routes (`flowdrop_ai_provider.routing.yml`)

**Every route requires `_permission: administer flowdrop`.** They are internal endpoints for the FlowDrop
editor UI (list/create prompts, prompt types, guardrail sets, and a live node config schema).

| Route | Path | Method | Controller method |
|---|---|---|---|
| `…api.ai_prompts.list` | `/api/flowdrop/ai-prompts` | GET | `AiPromptApiController::listPrompts` |
| `…api.ai_prompts.create` | `/api/flowdrop/ai-prompts` | POST | `AiPromptApiController::createPrompt` |
| `…api.ai_prompts.autocomplete` | `/api/flowdrop/ai-prompts/autocomplete` | GET | `AiPromptApiController::autocompletePrompts` |
| `…api.ai_prompt_types.list` | `/api/flowdrop/ai-prompt-types` | GET | `AiPromptApiController::listPromptTypes` |
| `…api.ai_provider.schema` | `/api/flowdrop/ai-provider/config-schema` | GET | `AiProviderSchemaController::schema` |
| `…api.guardrail_sets.autocomplete` | `/api/flowdrop/guardrail-sets/autocomplete` | GET | `GuardrailSetApiController::autocompleteGuardrailSets` |
| `…api.guardrail_sets.detail` | `/api/flowdrop/guardrail-sets/{guardrail_set_id}` | GET | `GuardrailSetApiController::getGuardrailSet` |

- `AiPromptApiController` (delegates to `ai.prompt_manager`) — `createPrompt` validates `label`/`prompt`,
  verifies the prompt type exists, and `upsertPrompt()`s a machine name derived from the label
  (optionally `{workflowId}__{label}`). `@internal`.
- `AiProviderSchemaController` (uses `flowdrop.node_processor_plugin_manager`) — returns only
  `configurable` params (from the node-type entity) + defaults for `?plugin=flowdrop_ai_provider:<id>`;
  no page cache so dropdowns stay fresh. Rejects missing/unknown plugins with `BadRequestHttpException`.
- `GuardrailSetApiController` (uses `ai.guardrail_repository`) — autocomplete + full detail (pre/post
  guardrail lists, stop threshold, edit URLs) for a guardrail set. `@internal`.
