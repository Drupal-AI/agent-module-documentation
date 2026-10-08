# The `openai` AiProvider plugin

This module **consumes** AI Core's `AiProvider` plugin type — it does not define any plugin
type of its own. It registers exactly one plugin.

## Plugin

`src/Plugin/AiProvider/OpenAiProvider.php`

```php
#[AiProvider(id: 'openai', label: new TranslatableMarkup('OpenAI'))]
class OpenAiProvider extends OpenAiBasedProviderClientBase { use ChatTrait; }
```

- Base class `Drupal\ai\Base\OpenAiBasedProviderClientBase` (AI Core) wraps the
  `openai-php/client` SDK; this class overrides the operation methods.
- Discovered by AI Core's `ai.provider` manager (`AiProviderPluginManager`); you reach it via
  `$manager->createInstance('openai')` — see [../api/ai_provider_openai.md](../api/ai_provider_openai.md).

## Supported operation types

`getSupportedOperationTypes()` returns:

| Operation type | Method implemented | Model default (setup) |
|---|---|---|
| `chat` | `chat($input, $model_id, $tags)` → `ChatOutput` | `gpt-5.2` |
| `embeddings` | `embeddings(...)` → `EmbeddingsOutput`; `embeddingsVectorSize($model)` | `text-embedding-3-small` |
| `moderation` | `moderation(...)` → `ModerationOutput` | `omni-moderation-latest` |
| `text_to_image` | `textToImage(...)` → `TextToImageOutput` (returns `ImageFile`s) | `gpt-image-1` |
| `text_to_speech` | `textToSpeech(...)` → `TextToSpeechOutput` (`AudioFile`) | `tts-1-hd` |
| `speech_to_text` | `speechToText(...)` → `SpeechToTextOutput` | `whisper-1` |

(Operation-type input/output interfaces live in AI Core's `src/OperationType/<Name>/`.)

## Chat capabilities

The `chat()` implementation handles: system prompts (mapped to a `user` role for o1/o3),
image inputs (`ImageFile` → `image_url`), PDF file inputs, multi-part content, streaming
(`createStreamed` + `OpenAiChatMessageIterator`), Fiber-based async streaming, **tool /
function calling** (`getChatTools()->renderToolsArray()`), and **structured JSON-schema
responses** (`getChatStructuredJsonSchema()` → `response_format: json_schema`).

## Model discovery & per-model settings

- `getConfiguredModels($operation_type, $capabilities)` lists live models from the OpenAI
  models endpoint (cached), filtered per operation type and per `AiModelCapability`
  (ChatWithImageVision, ChatJsonOutput, ChatTools, ChatStructuredResponse, …).
- `getModelSettings($model_id, $config)` tunes the settings form per model: `max_tokens`
  becomes `max_completion_tokens` and penalties/temperature are dropped for gpt-5/o-series;
  `reasoning_effort` (minimal/low/medium/high) is added for reasoning models; `quality`,
  `size`, `output_format` for `gpt-image-*`; `dimensions` 3072 for `text-embedding-3-large`.

## Moderation gate

`moderationEndpoints($prompt, $tags)` runs before chat/image/tts/embeddings calls when the
`moderation` config flag is on. Pass a `skip_moderation` tag to bypass a single call, or call
`enableModeration()` / `disableModeration()` on the provider. A flagged prompt throws
`Drupal\ai\Exception\AiUnsafePromptException`. Rate-limit / quota errors are translated to
`AiRateLimitException` / `AiQuotaException`.

## Writing your own provider

To add a different vendor, don't edit this module — create your own
`#[AiProvider(id: 'myvendor')]` plugin in your module (see AI Core's plugins doc). This module
is the reference implementation for an OpenAI-style REST vendor.
