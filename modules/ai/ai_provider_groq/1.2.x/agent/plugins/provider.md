# The `groq` AI provider plugin

The module's only real code surface: one `AiProvider` plugin that plugs Groq's OpenAI-compatible API
into the `ai` module. It does **not** define a plugin type — it is a single plugin *instance* of the
`AiProvider` type owned by `drupal/ai`.

- Class: `Drupal\ai_provider_groq\Plugin\AiProvider\GroqProvider`
  (`src/Plugin/AiProvider/GroqProvider.php`).
- Attribute: `#[AiProvider(id: 'groq', label: new TranslatableMarkup('Groq'))]`.
- Base class: `Drupal\ai\Base\OpenAiBasedProviderClientBase` (the shared OpenAI-compatible client),
  plus `use ChatTrait`.
- Manager: `ai.provider` (`Drupal\ai\AiProviderPluginManager`). Instantiate with
  `\Drupal::service('ai.provider')->createInstance('groq')`.
- API base URI: `protected string $endpoint = 'https://api.groq.com/openai/v1';`
  (`GroqProvider.php:27`). HTTPS; the HTTP client is Drupal's `http_client` (Guzzle) with default
  TLS verification.

## What it implements / overrides

| Method | Behaviour |
|---|---|
| `getSupportedOperationTypes()` | Returns exactly `['chat']` — Groq here is a **chat-only** provider (runtime-verified). |
| `getSetupData()` | `key_config_name => 'api_key'`, `default_models => ['chat' => 'llama-3.3-70b-versatile']`. Used by the AI module's setup wizard. |
| `getConfiguredModels($operation_type, $capabilities)` | Live-lists models from `GET /models`, cached; see filtering below. |
| `getOperationSettings($operation_type)` | Builds the per-request settings array (see configure/settings.md). |
| `getModelSettings($model_id, $generalConfig)` | Merges operation-specific settings into the general config when `$generalConfig['operation_type']` is set. |
| `modelSupportsReasoning($model_id)` | Helper: TRUE when the id contains `-qwq-` or `deepseek`. |

Capabilities are **inherited** from the base class `getSupportedCapabilities()`:
`AiProviderCapability::StreamChatOutput` and `AiProviderCapability::ChatFiberSupport` (streaming +
fiber/async chat). Groq does not override these.

## Model discovery / filtering (`getConfiguredModels`)

Fetches `$this->getClient()->models()->list()` and caches under key
`groq_models_<operation_type>_<hashBase64(json(capabilities))>` in the default cache backend, then:

- Skips text-to-speech ids beginning `playai-tts`.
- Skips speech-to-text ids beginning `whisper` or `distil-whisper`.
- When `AiModelCapability::ChatWithImageVision` is requested, keeps only ids containing `vision`.
- When `AiModelCapability::ChatTools` (function calling) is requested, keeps only ids in the
  **hardcoded** `$toolCallingModels` allow-list:
  `qwen-qwq-32b`, `qwen-2.5-coder-32b`, `qwen-2.5-32b`, `deepseek-r1-distill-qwen-32b`,
  `deepseek-r1-distill-llama-70b`, `llama-3.3-70b-versatile`, `llama-3.1-8b-instant`,
  `mixtral-8x7b-32768`, `gemma2-9b-it`.
- Otherwise returns every remaining id. Results are `asort()`ed before caching.

Because the tool-calling list is hardcoded, a newly released Groq model that supports tools will not
appear for `ChatTools` until the list is updated — clear caches after any provider update.

## Request settings sent to the API

`chat()` (in the base class) sends `model` + `messages` plus `$this->configuration`. The provider's
`getOperationSettings()` seeds that configuration from `ai_provider_groq.settings` (and any operation
override): `reasoning_format` (default `hidden`), `temperature` (default `0.6`),
`max_tokens` (default `1024`), `json_mode` (default `FALSE`). See
[configure/settings.md](../configure/settings.md) for the config keys and the override mechanism.

`definitions/api_defaults.yml` declares the operation contract the AI module's generic explorer/forms
use for a `chat` call — the tunable per-call fields: `max_tokens`, `temperature` (0–2),
`frequency_penalty`, `presence_penalty`, `top_p`, `reasoning_format` (`n/a`/`parsed`/`raw`/`hidden`),
`json_mode`; `input` and `authentication` (the Groq API key) are marked required.

## Call it from code

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager = \Drupal::service('ai.provider');
$groq = $manager->createInstance('groq');

$messages = new \Drupal\ai\OperationType\Chat\ChatInput([
  new \Drupal\ai\OperationType\Chat\ChatMessage('user', 'Summarise this in one line: ...'),
]);
/** @var \Drupal\ai\OperationType\Chat\ChatOutput $out */
$out = $groq->chat($messages, 'llama-3.3-70b-versatile');
$text = $out->getNormalized()->getText();
```

The API key is not passed here — it is resolved from configuration via the Key module (see
configure/settings.md). Use `$manager->getDefaultProviderForOperationType('chat')` if you want the
site-configured default provider/model instead of hardcoding `groq`.
