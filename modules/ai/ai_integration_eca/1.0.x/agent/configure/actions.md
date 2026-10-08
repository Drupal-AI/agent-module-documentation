# The ECA AI actions

These are ordinary ECA `@Action` plugins. You add them inside an **ECA model** (Modeller UI or
ECA config), not on any module settings page. Requires the AI module configured with at least one
provider + model for the relevant operation type.

## Common config (all actions — `AiActionBase`)

| Field | Config key | Notes |
|---|---|---|
| Model | `model` | Select of `provider__model` options from `ai.provider->getSimpleProviderModelOptions(<operationType>)`. Required; validated to contain exactly one `__`. Added as a module dependency. |
| Token input | `token_input` | ECA token reference holding the input data. |
| Token result | `token_result` | ECA token the AI response is written to for later steps. |

`AiConfigActionBase` (all except Moderation) adds:

| Field | Config key | Notes |
|---|---|---|
| Specific configuration for the model | `config` | YAML textarea for model params (e.g. `temperature`, `voice`, `response_format`). Parsed by `eca.service.yaml_parser`; **validated** against `provider->getAvailableConfiguration($operationType,$model)` via `ai_integration_eca.provider_validator` — invalid keys/ranges block save and block the action's `access()`. |

## Per-action

| Action id | Label | Operation type | Extra config | Execution result |
|---|---|---|---|---|
| `ai_integration_eca_execute_chat` | Chat | `chat` | `prompt` (textarea, token-replaced, required), `schema` (optional JSON schema for structured output) | Trimmed chat text → `token_result` (or "No result could be generated."). |
| `ai_integration_eca_execute_embedding` | Embedding | `embeddings` | — | Embedding response wrapped in a `DataTransferObject` → `token_result`. |
| `ai_integration_eca_execute_moderation` | Moderation | `moderation` | — (extends `AiActionBase`, no YAML config) | DTO `{flagged: bool, information: ...}` → `token_result`. |
| `ai_integration_eca_execute_stt` | Speech to Text | `speech_to_text` | — | Reads `token_input` as a **file path**, `file_get_contents`, transcribes → normalized text in `token_result`. |
| `ai_integration_eca_execute_tts` | Text to Speech | `text_to_speech` | — | Synthesizes audio, saves `public://audio.mp3` (`getAsFileEntity`), stores the file URL in `token_result`. |

### Chat specifics

- **Prompt** is run through the ECA token service (`tokenService->replace`) with the input token's
  data, so you can interpolate `[node:title]`-style tokens and ECA tokens.
- **System prompt:** put `system_name:` and `system_prompt:` keys in the `config` YAML; Chat pulls
  them out and sends them as a second `ChatMessage` (they're removed from the model config first).
  Both are validated as optional strings.
- **Schema:** if non-empty, JSON-decoded and applied via `setChatStructuredJsonSchema()`; malformed
  JSON is silently ignored.

## Notes

- Each action's `getModelData()` splits `model` on `__` into `provider_id` / `model_id`; a bad value
  throws `InvalidArgumentException`.
- `AiConfigActionBase::access()` re-parses and re-validates the YAML config at run time, returning
  `AccessResult::forbidden(<message>)` if the YAML is invalid or violates the provider constraints —
  so a misconfigured action won't execute.
- There is no admin route, permission, or Drush command in this module; access is governed by ECA
  (configuring ECA models requires ECA admin permissions).
