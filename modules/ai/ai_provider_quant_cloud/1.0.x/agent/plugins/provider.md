<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `quant_cloud` AI provider plugin

Class: `Plugin\AiProvider\QuantCloudProvider` (extends `Drupal\ai\Base\AiProviderClientBase`), declared with `#[AiProvider(id: 'quant_cloud', label: 'Quant Cloud AI')]`. Instantiate via `\Drupal::service('ai.provider')->createInstance('quant_cloud')`.

Implements `ChatInterface`, `EmbeddingsInterface`, `TextToImageInterface`, `ImageToImageInterface`. `getSupportedOperationTypes()` → `chat`, `embeddings`, `text_to_image`, `image_to_image`. `create()` injects the `.client`, `.streaming_client`, `.models` services and the logger.

## Discovery & capability plumbing

- `getConfig()` → immutable `ai_provider_quant_cloud.settings`.
- `getApiDefinition()` parses `definitions/api_defaults.yml` (per-op parameter schema).
- `isUsable($op)` → true only when `auth.access_token_key`, `auth.organization_id`, `platform` are set (and, if `$op` given, it is in the supported list).
- `getConfiguredModels($op, $capabilities)` maps the Drupal op to an API feature (`chat`, `embeddings`, `image_generation`), calls `ModelsService::getModels($feature)`, and filters by capability via `mapCapabilityFlag()` (`chat_tools`→`supportsTools`, `chat_json_output`→`supportsStructuredOutput`, `chat_with_image_vision`→`supportsVision`, etc.). Returns `[model_id => label]`.
- `embeddingsVectorSize()` and `getMaxInputTokens()/getMaxOutputTokens()` return per-model values (API-first, then a hard-coded fallback table); `maxEmbeddingsInput()` = 96.

## chat()

`chat(ChatInput|array|string $input, string $model_id, array $tags)`. Normalizes strings/arrays to `ChatInput`, then `formatMessages()` builds the API `messages` array. Options assembled: `responseFormat` (from `getChatStructuredJsonSchema()` → `{type:json, jsonSchema}`), `toolConfig.tools` (from `getChatTools()` via `formatToolsForApi()`), `systemPrompt` (from base-class `chatSystemRole` or `$input->getSystemRole()`).

- **Streaming** (`$this->streamed` true, set via `setStreamed()`): calls `streamingClient->chatStreamRaw()` and wraps the stream in `QuantCloudChatMessageIterator::create()`, returned inside a `ChatOutput`.
- **Buffered** (default): `client->chat()`; reads `response.content`/`response.role`/`response.toolUse` (or flat `text`/`content` fallback). Tool-use blocks are turned into `ToolsFunctionOutput` objects (resolved against the input's tool definitions) and attached via `$message->setTools()`.

`formatMessages()` targets Bedrock's Converse shape: assistant messages with tool calls emit `toolUse` content blocks (`Json::decode` of the rendered arguments); `tool`/`tool_result` role (or messages with a tools id) become a `user` message carrying a `toolResult` block; messages with images emit multimodal content via `formatImageFile()` (`{image:{format, source:{bytes: base64}}}`). `formatAttachment()`/`formatBase64Content()`/`formatS3Content()` additionally support video/document blocks and `s3://` URIs. Note `formatAttachment()` will `file_get_contents()` a local `uri` attachment — only reached for caller-supplied attachment arrays, not remote input.

## embeddings()

`embeddings(string|EmbeddingsInput, $model_id, $tags)`. Extracts the prompt text, calls `client->embeddings()`, wraps `result['embeddings']` in an `EmbeddingsOutput`.

## textToImage() / imageToImage()

Both build a Nova Canvas payload for `client->post('image-generation', …)` (60 s timeout). Task type from `configuration['task_type']` (`TEXT_IMAGE`, `IMAGE_VARIATION`, `INPAINTING`, `OUTPAINTING`, `BACKGROUND_REMOVAL`); source images are base64-encoded from the input's `ImageFile`/mask. `imageGenerationConfig` is filled from provider `configuration` (resolution/custom size, quality, numberOfImages, cfgScale, seed, region). The response `images[]` (data URLs or raw base64) are decoded into `ImageFile` objects. `requiresImageToImageMask()` is true only for `INPAINTING`; `requiresImageToImagePrompt()` false only for `BACKGROUND_REMOVAL`.

Parameter ranges and options for every op are defined in `definitions/api_defaults.yml` (e.g. chat `max_tokens` 1–8192, `temperature` 0–1; image resolutions, styles, CFG scale, AWS regions).

## Streaming iterator

`QuantCloudChatMessageIterator` (in `src/`) reads the SSE body line by line; for each `data: {...}` line it yields `delta`/`role`/`usage` (and `toolUse`/`stopReason`/`content` for tool events), stopping on `complete: true`. `getIterator()` re-yields these as `StreamedChatMessage` objects for the AI module to consume.
