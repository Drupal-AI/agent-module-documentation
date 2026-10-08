# The `anthropic` AiProvider plugin

This module **consumes** AI Core's `AiProvider` plugin type — it does not define any plugin
type of its own. It registers exactly one plugin.

## Plugin

`src/Plugin/AiProvider/AnthropicProvider.php`

```php
#[AiProvider(id: 'anthropic', label: new TranslatableMarkup('Anthropic'))]
class AnthropicProvider extends OpenAiBasedProviderClientBase { use ChatTrait; }
```

- Base class `Drupal\ai\Base\OpenAiBasedProviderClientBase` (AI Core); endpoint
  `https://api.anthropic.com/v1` (overridable via the `host` config value in `loadClient()`).
- Discovered by AI Core's `ai.provider` manager (`AiProviderPluginManager`); reach it via
  `$manager->createInstance('anthropic')` — see [../api/ai_provider_anthropic.md](../api/ai_provider_anthropic.md).

## Supported operation types

`getSupportedOperationTypes()` returns **only**:

| Operation type | Method | Default model (setup) |
|---|---|---|
| `chat` | `chat($input, $model_id, $tags)` → `ChatOutput` (via `ChatTrait`) | Sonnet 4.5 / Opus 4.5 per op-type variant |

No embeddings, moderation, image, speech, etc. — Anthropic here is a **chat-only** provider.
The chat op-type variants (`chat_with_image_vision`, `chat_with_tools`,
`chat_with_complex_json`, `chat_with_structured_response`) are handled through the same `chat`
support plus AI Core's capability system.

## Model discovery (`fetchAvailableModels` / `getConfiguredModels`)

- `getConfiguredModels($operation_type, $capabilities)` returns models fetched **live** from
  `GET https://api.anthropic.com/v1/models` (header `anthropic-version: 2023-06-01`,
  `x-api-key`), keyed by model id → display name.
- Result is cached under key `ai_provider_anthropic:models` for `models_cache_ttl` seconds
  (default 86400). On fetch failure it logs a warning and returns `[]` (graceful degradation).
- Capability filter: passing `AiModelCapability::ChatJsonOutput` in `$capabilities` keeps only
  models matching `claude-3.[57] | claude-3-[57] | claude-4 | claude-(opus|sonnet)-4`.
- `clearModelsCache()` deletes the cached list (e.g. after adding access to new models).

## Per-model settings (`getModelSettings`)

For Claude **4.x and higher** model ids, `top_p` is unset from the general config — Anthropic's
API rejects sending `temperature` and `top_p` together. The tunable chat settings (from
`definitions/api_defaults.yml`) are: `max_tokens` (default 4096), `temperature` (0–1),
`top_p` (0–1), `top_k`.

## Moderation & error handling

- Anthropic has no native moderation. A `moderation` property + `enableModeration()` /
  `disableModeration()` exist (inherited pattern), but real pre-call moderation is wired
  through the **AI External Moderation** module + OpenAI — see
  [../configure/settings.md](../configure/settings.md).
- `handleApiException()` translates the "credit balance is too low" error into
  `Drupal\ai\Exception\AiQuotaException`; setup failures raise `AiSetupFailureException`.

## Writing your own provider

To add a different vendor, don't edit this module — create your own
`#[AiProvider(id: 'myvendor')]` plugin in your module (see AI Core's plugin docs). This module
is a compact reference for a chat-only, dynamically-discovered REST vendor.
