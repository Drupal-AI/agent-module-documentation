<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `siliconflow` provider plugin + `SiliconflowApi` service

## Plugin

`src/Plugin/AiProvider/SiliconflowProvider.php` — `#[AiProvider(id: 'siliconflow', label: 'Siliconflow')]`,
extends `Drupal\ai\Base\AiProviderClientBase`, implements `ContainerFactoryPluginInterface`,
`ChatInterface`, `EmbeddingsInterface`, `ImageClassificationInterface`, uses `ChatTrait`.
`create()` injects the `ai_provider_siliconflow.api` service as `$this->client`.
`hasPredefinedModels = FALSE` (models are admin-entered).

`getSupportedOperationTypes()` → `['chat', 'embeddings', 'text_to_image']`. `supportedTypes`
also maps each to a SiliconFlow list filter (`chat`, `embedding`, `text-to-image`); the
`image_classification` filter is commented out. `isUsable()` requires a configured `api_key`.

Each operation reads the admin-entered `siliconflow_endpoint` for the chosen model via
`getModelInfo()` and throws `AiMissingFeatureException` if missing.

- **chat()** — concatenates messages into a single `role: text\n` string (SiliconFlow has no
  system role → a warning is logged and it is dropped; images throw `AiMissingFeatureException`),
  calls `client->textGeneration($endpoint, $chat_input)`, strips the echoed input from the reply,
  and returns a `ChatOutput`. "Rate limit reached" → `AiRateLimitException`.
- **embeddings()** — calls `client->featureExtraction($endpoint, $input)` and returns an
  `EmbeddingsOutput`. `maxEmbeddingsInput()` returns 1024.
- **imageClassification()** — writes the image binary to a temp file, calls
  `client->imageClassification($endpoint, $tempFile)`, maps rows to `ImageClassificationItem`.
- **textToImage()** — calls `client->textToImage($endpoint, $prompt)`, then for each
  `data` item decodes `b64_json` into an `ImageFile`, or fetches `data.url` via
  `file_get_contents()` (the URL comes from SiliconFlow's own API response). Rate-limit / quota
  messages map to the AI exceptions.

`loadModelsForm()` adds the `siliconflow_endpoint` textfield with the autocomplete route (see
[../config/settings.md](../config/settings.md)). `getApiDefinition()` parses
`definitions/api_defaults.yml`. `getConfig()` → `ai_provider_siliconflow.settings`.
`setAuthentication()` / `loadClient()` push the Key value into the API client via
`SiliconflowApi::setApiToken()`.

## Service: `SiliconflowApi`

`src/SiliconflowApi.php`, service `ai_provider_siliconflow.api`, constructed with `@http_client`.
Holds the bearer token (`setApiToken()` / `isApiSet()`) and a serverless base
`https://api.siliconflow.cn/v1`.

- Task methods: `textGeneration` (`/chat/completions`), `featureExtraction` (`/v1/embeddings`),
  `textToImage` (`/images/generations`, fixed `image_size 1024x1024`, `batch_size 1`), plus
  `fillMask`, `summarization`, `questionAnswering`, `tableQuestionAnswering`,
  `sentenceSimilarity`, `textClassification`, `tokenClassification`, `translation`,
  `zeroShotClassification`, `conversational`, `automaticSpeechRecognition`, `audioClassification`,
  `imageClassification`, `objectDetection`, `imageSegmentation`. `getModel()` / `getUserData()`
  hit `https://siliconflow.co/api/...`.
- `finalEndpoint($endpoint)` returns the value as-is if it starts with `http(s)://` (dedicated
  endpoint), else prefixes the serverless base.
- `makeRequest($endpoint, $json, $file, $method='POST')` throws if no token; sets
  `connect_timeout`/`read_timeout` = 120, the `Authorization: Bearer <token>` header, JSON body
  (or a file stream), issues the Guzzle request, and returns the raw response body.
