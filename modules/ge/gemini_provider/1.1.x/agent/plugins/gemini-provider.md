<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `gemini` AI provider plugin

`src/Plugin/AiProvider/GeminiProvider.php` — `#[AiProvider(id: 'gemini', label: 'Gemini')]`,
extending the AI module's provider base (`AiProviderClientBase`). This is a **plugin of the AI
module's `ai_provider` type**, not a new plugin type defined here. It is created via the AI
module's provider manager:

```php
$provider = \Drupal::service('ai.provider')->createInstance('gemini');
```

## Supported operation types

`getSupportedOperationTypes()` returns:

- `chat` (text and image → text; supports tools/streaming/structured response)
- `embeddings` (text, image, or both → vector)
- `text_to_image`
- `text_to_speech`
- `speech_to_text`

`getSupportedCapabilities()` declares `AiProviderCapability::StreamChatOutput`.
`isUsable($operation_type)` returns TRUE only when an `api_key` is configured and (if given)
the operation type is supported.

## Default models (`getSetupData()`)

| Key | Model |
|---|---|
| `chat` | `models/gemini-3.8-flash` |
| `chat_with_image_vision` | `models/gemini-3.8-flash` |
| `chat_with_complex_json` | `models/gemini-3.8-flash` |
| `chat_with_tools` | `models/gemini-3.8-flash` |
| `chat_with_structured_response` | `models/gemini-3.8-flash` |
| `embeddings` | `models/gemini-embedding-2` |
| `speech_to_text` | `models/gemini-3.8-flash` |
| `text_to_image` | `models/gemini-3.1-flash-image` |
| `text_to_speech` | `models/gemini-3.8-flash-tts` |

`key_config_name` is `api_key`.

## Embeddings vector sizes (`embeddingsVectorSize()`)

- `models/gemini-embedding-001`, `models/gemini-embedding-2`,
  `models/gemini-embedding-2-preview` → **3072**
- otherwise → the AI base provider default (`parent::embeddingsVectorSize()`)

`maxEmbeddingsInput()` returns **8192** for `gemini-embedding-2` / `gemini-embedding-2-preview`,
otherwise **2048**. Only `gemini-embedding-2` is multimodal — `embeddings()` throws
`AiResponseErrorException` if an image is passed to any other embedding model.

## Listing models (`getConfiguredModels()`) — needs a live key

Calls the Gemini API to enumerate models and filters them **per operation type**:

- `embeddings` — model must support the `embedContent` method.
- `text_to_image` — model must support `generateContent` and have `image` in its name
  (Imagen's `predict` API and plain chat models are excluded).
- `text_to_speech` — model name must match `/-tts/i`.
- `speech_to_text` and default (chat) — model must support `generateContent` and not be a
  specialized model.

`SPECIALIZED_MODEL_PATTERNS` filters out `imagen-`, `veo-`, `-tts`, `-transcribe`,
`native-audio`, `robotics`, `computer-use`, `deep-research` and `models/aqa`. Because it makes
a real API request, it will fail without a valid API key — do not rely on it in offline tests
(it throws `AiResponseErrorException` on a `\JsonException`).

## Parameters (`definitions/api_defaults.yml`)

Per operation type. Chat: `stopSequences`, `maxOutputTokens` (default 1024), `temperature`
(0–2), `topP`, `topK`, `responseSchema`, `responseMimeType` (default `text/plain`).
`text_to_image`: `aspectRatio` (default `1:1`; supports 1:1, 2:3, 3:2, 3:4, 4:3, 9:16, 16:9).
`text_to_speech`: `voiceName` (e.g. Kore, Puck, Charon, Fenrir, Aoede, Leda, Orus, Zephyr),
`languageCode` (BCP 47). `speech_to_text`: `language` (ISO-639-1).

## Chat: tools, structured output, token usage

Chat supports image input (parts become Gemini `Blob`s via `createBlob()`, which maps MIME
aliases such as `image/jpg`→`image/jpeg` and `audio/x-wav`→`audio/wav`), tool/function calling
(`buildSchema()` → `FunctionDeclaration`/`Tool`, executed through the AI function-call plugin
manager) and structured JSON output (OpenAI-style schema converted to Gemini's native `Schema`
by `convertJsonSchemaToGeminiSchema()`). Token usage (prompt, output, total, reasoning/thoughts,
cached) is read from `usageMetadata` into a `TokenUsageDto` for non-streamed, non-fiber chat.
System messages are mapped to Gemini's `model` role; `assistant` is remapped to `user`.

## Speech-to-text, text-to-image, text-to-speech

- `speechToText()` — no dedicated STT endpoint; sends the audio Blob plus a transcription
  prompt to `generateContent` (language, if configured, is named in the prompt).
- `textToImage()` — `generateContent` with `responseModalities: [IMAGE]` and optional
  `imageConfig` aspect ratio; decodes inline image parts into `ImageFile`s.
- `textToSpeech()` — `generateContent` with `responseModalities: [AUDIO]` and optional
  `speechConfig` (voice/language). Raw-PCM preview output (not starting with `RIFF`) is wrapped
  in a 44-byte WAV header by `pcmToWav()` (24 kHz) so it is browser-playable.

## Streaming & safety

Streamed chat responses are wrapped by `Drupal\gemini_provider\GeminiChatMessageIterator`.
Configured `safety_settings` are applied to each generative call by `applySafetySettings()`.
The raw client is `\Gemini::factory()->withApiKey(...)->withHttpClient($this->httpClient)->make()`,
reusing Drupal's HTTP client.
