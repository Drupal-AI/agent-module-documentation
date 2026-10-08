<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operations — ai_provider_mistral

`MistralProvider` implements three `ai` operation-type interfaces. All calls go through the
`partitech/php-mistral` `MistralClient`, built lazily in `loadClient()` with the resolved API key and
the optional `host` override.

## chat (ChatInterface)
`chat($input, $model_id, $tags)` → `ChatOutput`.
- Accepts a string, an array of role/content messages, or a `ChatInput`; normalises to `ChatMessage`s.
- Adds the AI module's system role first, then each message. Handles: tool-response messages
  (`addToolMessage`), assistant messages that carry prior tool calls (`ToolCallCollection`), and
  multimodal messages — image files sent as `MESSAGE_TYPE_IMAGE_URL`, other files as
  `MESSAGE_TYPE_DOCUMENT_URL`, each as a base64-encoded string.
- Request params = `['model' => $model_id] + $this->configuration`, where configuration supplies
  `max_tokens` (default 1024), `temperature` (0–1, default 0.7), `top_p` (0–1, default 1) per
  `definitions/api_defaults.yml`.
- **Tools**: if `$input->getChatTools()`, `renderTools()` builds the tools array (injecting an empty
  object schema where a function declares no parameters). Response tool calls are mapped back to
  `ToolsFunctionOutput`.
- **Structured output**: if a JSON schema is supplied, `response_format` is set to
  `{type: json_schema, json_schema: …}`.
- **Streaming**: `isStreamedOutput()` → returns a `MistralChatMessageIterator` (a
  `StreamedChatMessageIterator`) that manually iterates the SDK Generator to survive re-iteration by
  `ReplayedChatMessageIterator` / `PromptJsonDecoder`.
- **Non-streaming**: extracts text (skipping "thinking" chunks), maps tool calls, and records
  `TokenUsageDto` from `usage.prompt_tokens` / `completion_tokens` / `total_tokens`.
- Raw response is normalised to an array by `MistralResponseTrait::responseToArray()` because the
  SDK `Response` uses private props and won't `json_encode` directly.

## embeddings (EmbeddingsInterface)
`embeddings($input, $model_id, $tags)` → `EmbeddingsOutput`. Sends `[$input]` to
`$client->embeddings(...)`; returns `data[0].embedding`. `getConfiguredModels('embeddings')` returns
only `mistral-embed`. `maxEmbeddingsInput()` reads the model's `max_context_length` from `/models`
(default 1024), cached 24h.

## moderation (ModerationInterface)
`moderation($input, $model_id, $tags)` → `ModerationOutput`. Model defaults to
`mistral-moderation-latest`. Calls `$client->moderation($model, $input, FALSE)` (full response),
sets `flagged` TRUE if any category is flagged, and returns per-category `category_scores` in a
`ModerationResponse`.

## Model listing & capability filtering
`getConfiguredModels($operation_type, $capabilities)` (cached 24h per operation+capabilities):
- `chat` — lists models from `/models` where `capabilities.completion_chat`; further filters on
  `AiModelCapability::ChatWithImageVision` (`capabilities.vision`),
  `ChatTools` (`capabilities.function_calling`), and `ChatJsonOutput` / `ChatStructuredResponse`.
- `embeddings` — static `mistral-embed`.
- `moderation` — models where `capabilities.moderation`.

## Error handling
`handleApiException()` maps `MistralClientException` codes to typed `ai` exceptions: 429 / "rate
limit" → `AiRateLimitException`; 402 / "quota"/"insufficient" → `AiQuotaException`; 400/401/403 →
`AiRequestErrorException`; everything else → `AiResponseErrorException`.

## Files API helpers (not operation types)
`uploadFile()` (purpose ocr/batch/fine-tune, default OCR), `getFileUrl()` (signed URL, default 24h),
`listFiles()`, `retrieveFile()`, `deleteFile()` — wrappers over the SDK for document/OCR/fine-tune
workflows.
