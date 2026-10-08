<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `gemini` AI provider plugin

`src/Plugin/AiProvider/GeminiProvider.php` — `#[AiProvider(id: 'gemini', label: 'Gemini')]`,
extending the AI module's provider base. This is a **plugin of the AI module's `ai_provider`
type**, not a new plugin type defined here. It is created via the AI module's provider manager:

```php
$provider = \Drupal::service('ai.provider')->createInstance('gemini');
```

## Supported operation types

`getSupportedOperationTypes()` returns:

- `chat` (text and image → text; supports tools/streaming/structured response)
- `embeddings` (text → vector)
- `text_to_image`
- `text_to_speech`
- `speech_to_text`

`isUsable($operation_type)` returns TRUE only when an `api_key` is configured and (if given)
the operation type is supported.

## Default models (`getSetupData()`)

| Key | Model |
|---|---|
| `chat` | `models/gemini-2.5-flash` |
| `chat_with_image_vision` | `models/gemini-2.5-flash` |
| `chat_with_complex_json` | `models/gemini-2.5-flash` |
| `chat_with_tools` | `models/gemini-2.5-flash` |
| `chat_with_structured_response` | `models/gemini-2.5-flash` |
| `embeddings` | `models/gemini-embedding-001` |

`key_config_name` is `api_key`.

## Embeddings vector sizes (`embeddingsVectorSize()`)

- `models/gemini-embedding-001` → **3072**
- `models/text-embedding-004` → **768**
- otherwise → 0

## Listing models (`getConfiguredModels()`) — needs a live key

Calls the Gemini API to enumerate models, then filters out ones unfit for chat via
`SPECIALIZED_MODEL_PATTERNS` (vision, embedding, `robotics`, `computer-use`, `deep-research`,
`aqa`, …). Because it makes a real API request, it will fail without a valid API key — do not
rely on it in offline tests.

## Parameters (`definitions/api_defaults.yml`)

Per operation type. Chat: `stopSequences`, `maxOutputTokens` (default 1024), `temperature`
(0–2), `topP`, `topK`, `responseSchema`, `responseMimeType` (default `text/plain`).
`text_to_image`: `aspectRatio` (default `1:1`). `text_to_speech`: `voiceName`, `languageCode`.
`speech_to_text`: `language`.

## Streaming & safety

Streamed chat responses are wrapped by `Drupal\gemini_provider\GeminiChatMessageIterator`.
Configured `safety_settings` are applied to each generative call by `applySafetySettings()`.
The raw client is `\Gemini::factory()->withApiKey(...)->withHttpClient(...)->make()`.
