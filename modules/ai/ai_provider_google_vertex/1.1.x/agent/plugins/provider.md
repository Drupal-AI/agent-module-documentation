<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VertexProvider plugin

`src/Plugin/AiProvider/VertexProvider.php` — `#[AiProvider(id: 'google_vertex', label: 'Google
Vertex')]`, extends `AiProviderClientBase`, implements `ChatInterface`, `EmbeddingsInterface`,
`TranslateTextInterface`, `ContainerFactoryPluginInterface`. Uses `ChatTrait`.

## Lifecycle / helpers

- `isUsable($operation_type)` — returns FALSE unless `general_credential_file` config is set; then
  checks the op is one of the supported types.
- `getSupportedOperationTypes()` → `['chat', 'embeddings', 'translate_text']`.
- `getConfig()` → immutable `ai_provider_google_vertex.settings`.
- `getApiDefinition()` → parses `definitions/api_defaults.yml`.
- `setAuthentication($file_location)` sets `$credentialFile` and resets the client.
- `loadClient()` lazily creates a plain `GuzzleHttp\Client` (`$this->client = new Client()`); the
  same instance serves chat, embeddings and translation POSTs.
- `getAccessToken()` / `getAuthHeaders()` — mint an OAuth2 bearer token from the service account
  (see config/settings.md) and return the `Authorization` header.
- `loadCredentials()` — resolves the Key entity named in config and JSON-decodes its value.
- `throwError($message)` — JSON-decodes an error body; maps `reason == CONSUMER_INVALID` to
  `AiMissingFeatureException`, other `reason` to `AiResponseErrorException`, else
  `AiBadRequestException`.

## chat()

- Requires model info keys `vertex_model_id`, `project_id`, `location` (else `AiBadRequestException`).
- Builds endpoint
  `https://{location}-aiplatform.googleapis.com/v1/projects/{project}/locations/{location}/publishers/google/models/{model}:generateContent`.
- Maps AI-module `ChatMessage`s to Vertex `contents` via `getMessageContent()` — role `user` vs
  `model`, `functionResponse`/`functionCall` parts, and `inlineData` (base64) for image inputs.
- Optional grounding: if the model has a `datastore` and no image is present, adds
  `tools.retrieval.vertexAiSearch.datastore`.
- Tools: `addTools()` translates AI-module function tools into Vertex `function_declarations`
  (name/description/parameters; all properties coerced to `type: string`).
- POSTs `['json' => $payload, 'headers' => $this->getAuthHeaders()]`; parses `candidates`,
  `modelVersion`, `promptFeedback`, `usageMetadata`; returns a `ChatOutput`.

## embeddings()

- Endpoint `…/models/{model}:predict`; payload `{"instances":[{"content": text}]}`.
- Flattens `predictions[].embedding` (or nested array fields) into a values array; returns
  `EmbeddingsOutput`. `maxEmbeddingsInput()` = 4096, `embeddingsVectorSize()` = 768.

## translateText()

- Uses the `TranslationModels` enum (`src/TranslationModels.php`) resolved from the model id.
  - **TLLM** → `…/publishers/google/models/cloud-translate-text:predict` with an `instances`
    payload; response read from `predictions[].translations[0].translatedText`.
  - **NMT** → `https://translation.googleapis.com/v3/projects/{project}:translateText`; response
    read from `translations[0].translatedText`.
- Both send `mimeType: text/html` and the source/target language codes from the `TranslateTextInput`.

## Streaming

`GoogleVertexChatIterator` (a `StreamedChatMessageIterator`) wraps a gRPC `Google\ApiCore\ServerStream`
and yields `StreamedChatMessage`s from each candidate. Streaming requires the gRPC PHP extension.
