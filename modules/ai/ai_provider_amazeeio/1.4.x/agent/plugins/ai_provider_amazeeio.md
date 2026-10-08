# Plugins registered by ai_provider_amazeeio

This module does **not define** any plugin types. It **implements** plugins for types owned by
AI Core (`ai`).

## `amazeeio` — AiProvider plugin

`src/Plugin/AiProvider/AmazeeioAiProvider.php`, attribute `#[AiProvider(id: 'amazeeio', label:
'amazee.ai AI')]`, class `AmazeeioAiProvider extends
\Drupal\ai\Base\OpenAiBasedProviderClientBase implements
\Drupal\ai\OperationType\TranslateText\TranslateTextInterface`. Const `PROVIDER_ID = 'amazeeio'`.

Because the amazee.ai gateway is OpenAI-compatible (LiteLLM), the provider reuses AI Core's
OpenAI base client. `loadClient()` builds an `AmazeeClient` from the raw Guzzle client, sets
the endpoint from config `host`, and loads the token from the `amazeeio_ai` Key (the OpenAI SDK
gets a Guzzle client stamped with the `X-Amazee-Client` header; a PSR-18 decorator would break
streaming — see #3586239).

Key methods:

| Method | Behaviour |
|---|---|
| `getSupportedOperationTypes()` | Returns `['chat', 'chat_with_complex_json', 'chat_with_image_vision', 'chat_with_structured_response', 'chat_with_tools', 'embeddings', 'text_to_image', 'translate_text']`. |
| `getSupportedCapabilities()` | `[AiProviderCapability::StreamChatOutput, AiProviderCapability::ChatFiberSupport]`. |
| `getEndpoint()` | Returns `ai_provider_amazeeio.settings` `host`. |
| `getConfiguredModels($op, $capabilities)` | Fetches models from the gateway (via `AmazeeClient`), filtered by operation type/capability, cached under `amazeeai:models:<op>[:caps]` for 24h (86400s). |
| `getModels($op, $capabilities)` | The filter itself — maps each model's `supports*`/`mode` flags to the operation type (chat, embeddings, text_to_image, translate_text, chat_with_image_vision→vision, chat_with_structured_response→responseSchema, chat_with_tools→functionCalling/toolChoice, etc.). |
| `getModelSettings($model_id, $general)` | Drops any general config param the model doesn't list in its `supportedOpenAiParams`. |
| `getSetupData()` | `key_config_name = 'api_key'`; seeds default model ids for chat, chat_with_tools, chat_with_structured_response, chat_with_complex_json, translate_text (+ image_vision if supported), embeddings, and text_to_image (see configure/settings.md). |
| `translateText($input, $model_id, $options)` | Implements `TranslateTextInterface` by building a chat prompt ("Translate the following text from X to Y …", system prompt "You are a helpful translator.") and calling `chat()`, returning a `TranslateTextOutput`. |
| `handleApiException($e)` | "Budget has been exceeded!" → `AiQuotaException` (on the anonymous trial, state `ai_provider_amazeeio.trial_account`, the message links to the settings form to upgrade); "Request rate limit has been exceeded" → `AiRateLimitException`; otherwise delegates to the OpenAI base handler, then rethrows. |

Per-operation config defaults (max_tokens, temperature, frequency/presence penalty, top_p for
chat; `text_to_image` n/size/response_format; plus text_to_speech / speech_to_text / embeddings
blocks) are declared in `definitions/api_defaults.yml`.

Model metadata is a `DTO\Model` built by `Model::createFromResponse()` from the gateway's
`/model/info` payload — `supportsChat`/`supportsEmbeddings`/`supportsImageGeneration` derive
from the `mode` field (`chat`/`embedding`/`image_generation`); vision, response-schema,
function-calling, tool-choice, moderation, audio, etc. come from `supports_*` flags;
`supportedOpenAiParams` from `supported_openai_params`.

## `amazeeio_vector_db` — AiVdbProvider plugin

`src/Plugin/VdbProvider/AmazeeioVdbProvider.php`, attribute `#[AiVdbProvider(id:
'amazeeio_vector_db', label: 'amazee.ai Vector Database')]`. A vector database provider (for AI
Core / Search AI) backed by **Postgres + pgvector**, using the
`ai_provider_amazeeio.postgres_client` service (`Vdb\Postgres\PostgresPgvectorClient`, now built
on **PDO** — `new \PDO(...)`). It reads the `postgres_*` keys from
`ai_provider_amazeeio.settings` and the DB password from the `amazeeio_ai_database` Key. This
lets embeddings produced by the `amazeeio` provider be stored and searched in an in-region
amazee.ai vector store. (Requires the `ext-pdo` + `ext-pdo_pgsql` PHP extensions — declared in
the module's `composer.json`; these replace the old `ext-pgsql`.) `hook_search_api_index_update`
syncs index fields into the Postgres collection when the AI Search server uses this database.

## `EnsureAmazeeAiAccess` — ConfigAction plugin

`src/Plugin/ConfigAction/EnsureAmazeeAiAccess.php`, action id `ensureAmazeeAiAccess`
(entity_types `['*']`) — lets recipes provision anonymous trial access programmatically via the
`TrialAccountProvisioner`. Failures are logged and swallowed so they never break an install.

## Client / trial-access internals (not plugins, for reference)

- `AmazeeIoApi\AmazeeClient` (service `ai_provider_amazeeio.api_client`) — talks to the gateway
  and the management API; `models()`, `getPrivateApiKeys()`, `createPrivateAiKey()`,
  `validateCode()`, `createManagementToken()`, `getTeam()`, `getKeySpend()`, `setToken()`,
  `setHost()`. Requests carry an `X-Amazee-Client: ai_provider_amazeeio/<version>` header, a 5s
  timeout, and exponential-backoff retry (3×, skips 4xx except transient 401).
- `TrialAccess\*` — anonymous free-trial account provisioning (`TrialKeyGenerator`,
  `TrialAccountProvisioner*`, `ProgressReporter*`), guarded by the
  `ai_provider_amazeeio.trial_access_provisioning.disable` service parameter (on in tests).
- `AiProviderAmazeeioServiceProvider` / `DisableTrialAccessProvisioningInTestsCompilerPass` —
  compiler-pass wiring for the above.
- Hooks live in `src/Hook/AiProviderAmazeeioHooks.php` (theme, search_api_index_update,
  user_login/logout, config_ignore_ignored_alter) with `.module` `#[LegacyHook]` shims.

## How to implement your own provider

You don't subclass this module. To add another AI vendor, implement AI Core's own
`#[AiProvider]` (and optionally `#[AiVdbProvider]`) attribute plugin — this module is just an
example of doing so against an OpenAI-compatible gateway.
