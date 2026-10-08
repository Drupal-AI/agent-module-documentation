<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HuggingfaceProvider plugin & HuggingfaceApi

## HuggingfaceProvider

`src/Plugin/AiProvider/HuggingfaceProvider.php` — `#[AiProvider(id: 'huggingface', label:
'Huggingface')]`, extends `AiProviderClientBase`, implements `ChatInterface`, `EmbeddingsInterface`,
`ImageClassificationInterface`, `SummarizationInterface`, `ObjectDetectionInterface`. `create()`
injects the `ai_provider_huggingface.api` service.

- `isUsable($op)` — FALSE unless `api_key` config is set; then checks the op is supported.
- `getSupportedOperationTypes()` → `chat`, `embeddings`, `image_classification`, `summarize`,
  `object_detection`. `$supportedTypes` maps each to a HF pipeline-tag filter.
- `getConfig()` → immutable `ai_provider_huggingface.settings`. `getApiDefinition()` parses
  `definitions/api_defaults.yml`.
- `setAuthentication($token)` / `loadClient()` — set the token on `HuggingfaceApi`.
- Every operation reads `getModelInfo($type, $model_id)` and requires `huggingface_endpoint` (else
  `AiMissingFeatureException`).

### chat()

Normalizes `ChatInput` (optional system role, then role/content messages). Three paths:
- `$this->streamed` → `HuggingfaceApi::chatCompletionsStreamed()` wrapped in
  `HuggingfaceChatMessageIterator`.
- Inside a `\Fiber` → streamed, suspending per chunk, then `reconstructChatOutput()`.
- Otherwise → `chatCompletions()` (non-streamed), reads `choices[0].message.content`.
Maps `usage` into a `TokenUsageDto`; a `Rate limit reached` error is rethrown as
`AiRateLimitException`.

### embeddings() / summarize() / imageClassification() / objectDetection()

- `embeddings()` → `HuggingfaceApi::featureExtraction()`, returns the decoded vector.
- `summarize()` → `summarization()`; reads `[0].summary_text`.
- `imageClassification()` / `objectDetection()` — write the input binary to a `tempnam()` file, POST
  it (`image/jpeg`), `unlink()` it, and map rows to `ImageClassificationItem` / `ObjectDetectionItem`
  (label, box, score).
- `maxEmbeddingsInput()` = 1024.

## HuggingfaceApi

`src/HuggingfaceApi.php` — a thin wrapper over the injected Guzzle `@http_client`. Base paths:
serverless `https://router.huggingface.co/hf-inference/models/`, chat
`https://router.huggingface.co/v1/chat/completions`.

- `finalEndpoint($endpoint)` — returns `$endpoint` unchanged if it starts with `http(s)://`, else
  prefixes the serverless base.
- `makeRequest()` — sets `connect_timeout`/`read_timeout` = 120, adds
  `Authorization: Bearer <token>` (throws if no token), JSON-encodes the body or streams a file
  handle for uploads, and returns the raw response body.
- `makeStreamedRequest()` — same auth, `stream => TRUE`, reads the body in 1 KB chunks and parses
  `data: …` SSE lines into decoded arrays via a `\Generator`, stopping at `data: [DONE]`.
- Also exposes many per-task helpers (`textGeneration`, `translation`, `questionAnswering`,
  `zeroShotClassification`, `automaticSpeechRecognition`, `getModel`, `getUserData`, etc.) that the
  provider does not all use directly but are available via `getClient()`.

## HuggingfaceChatMessageIterator

`src/HuggingfaceChatMessageIterator.php` — extends `StreamedChatMessageIterator`; `doIterate()`
yields `StreamedChatMessage`s from `choices[0].delta` (role/content/tool_calls), records
prompt/completion/total token usage from `usage`, and captures `finish_reason`.
