# Plugins registered by ai_provider_amazeeio

This module does **not define** any plugin types. It **implements** plugins for types owned by
AI Core (`ai`).

## `amazeeio` — AiProvider plugin

`src/Plugin/AiProvider/AmazeeioAiProvider.php`, attribute
`#[AiProvider(id: 'amazeeio', label: 'amazee.ai AI')]`, class `AmazeeioAiProvider extends
\Drupal\ai\Base\OpenAiBasedProviderClientBase`. Const `PROVIDER_ID = 'amazeeio'`.

Because the amazee.ai gateway is OpenAI-compatible (LiteLLM), the provider reuses AI Core's
OpenAI base client; `loadClient()` builds an `AmazeeClient`, reads `host` from config, and sets
it as the endpoint, then loads the token from the `amazeeio_ai` Key.

Key methods:

| Method | Behaviour |
|---|---|
| `getSupportedOperationTypes()` | Returns `['chat', 'chat_with_complex_json', 'chat_with_image_vision', 'chat_with_structured_response', 'chat_with_tools', 'embeddings']`. |
| `getSupportedCapabilities()` | `[AiProviderCapability::StreamChatOutput, AiProviderCapability::ChatFiberSupport]`. |
| `getEndpoint()` | Returns `ai_provider_amazeeio.settings` `host`. |
| `getConfiguredModels($op, $capabilities)` | Fetches models from the gateway (via `AmazeeClient`), filtered by operation type/capability, cached under `amazeeai:models:<op>[:caps]` for 24h (86400s). |
| `getModelSettings($model_id, $general)` | Drops any general config param the model doesn't list in its `supportedOpenAiParams`. |
| `getSetupData()` | `key_config_name = 'api_key'`; seeds default model ids for chat + embeddings (see configure/settings.md). |
| `handleApiException($e)` | Converts "Budget has been exceeded!" gateway errors into a typed `AiQuotaException`; on the anonymous free trial (state `ai_provider_amazeeio.trial_account`) the message links to the settings form to upgrade. |

Per-operation config defaults (max_tokens, temperature, frequency/presence penalty, top_p for
chat; plus text_to_image / text_to_speech / speech_to_text / embeddings blocks) are declared in
`definitions/api_defaults.yml`.

## `amazeeio_vector_db` — AiVdbProvider plugin

`src/Plugin/VdbProvider/AmazeeioVdbProvider.php`, attribute
`#[AiVdbProvider(id: 'amazeeio_vector_db', label: 'amazee.ai Vector Database')]`. A vector
database provider (for AI Core / Search AI) backed by **Postgres + pgvector**, using the
`ai_provider_amazeeio.postgres_client` service (`Vdb\Postgres\PostgresPgvectorClient`). It reads
the `postgres_*` keys from `ai_provider_amazeeio.settings` and the DB password from the
`amazeeio_ai_database` Key. This lets embeddings produced by the `amazeeio` provider be stored
and searched in an in-region amazee.ai vector store. (Requires the `ext-pgsql` PHP extension —
declared in the module's `composer.json`.)

## `EnsureAmazeeAiAccess` — ConfigAction plugin

`src/Plugin/ConfigAction/EnsureAmazeeAiAccess.php`, action id `ensureAmazeeAiAccess` on the
`amazeeio_ai` Key entity type — lets recipes provision trial access programmatically.

## Client / trial-access internals (not plugins, for reference)

- `AmazeeIoApi\AmazeeClient` (service `ai_provider_amazeeio.api_client`) — talks to the gateway
  and the management API; `models()`, `getPrivateApiKeys()`, `setToken()`, `setHost()`.
- `TrialAccess\*` — anonymous free-trial account provisioning (guarded by the
  `ai_provider_amazeeio.trial_access_provisioning.disable` service parameter, on in tests).
- `AiProviderAmazeeioServiceProvider` — compiler-pass wiring for the above.

## How to implement your own provider

You don't subclass this module. To add another AI vendor, implement AI Core's own
`#[AiProvider]` (and optionally `#[AiVdbProvider]`) attribute plugin — this module is just an
example of doing so against an OpenAI-compatible gateway.
