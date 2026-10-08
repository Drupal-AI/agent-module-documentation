<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `anythingllm` AI provider plugin & API client

`src/Plugin/AiProvider/AnythingllmProvider.php` — `#[AiProvider(id: 'anythingllm', label:
'AnythingLLM')]`, extends `AiProviderClientBase`, implements `ChatInterface`, `EmbeddingsInterface`
and the module's `AiSearchApiInterface`. It delegates all HTTP to the `ai_provider_anythingllm.api`
client (`AnythingllmApi`).

## Models & capability

- `hasPredefinedModels = FALSE`. `getConfiguredModels()` calls `AnythingllmApi::getModels()`
  (`GET workspaces`) and maps each workspace `slug => name`; on failure it logs and (for users with
  `administer ai providers`) shows a messenger error, returning `[]`.
- `getSupportedOperationTypes()` → `['chat', 'embeddings', 'ai_search_api']`.
- `isUsable()` returns FALSE until `AnythingllmApi::isApiSet()` (both key and URL present).
- `getApiDefinition()` parses `definitions/api_defaults.yml` (chat params: max_tokens, temperature,
  frequency/presence penalty, top_p; embeddings: input only). `maxEmbeddingsInput()` → 1024.
- `setAuthentication($auth)` accepts `['api_key' => …, 'api_url' => …]` and pushes both into the client.

## chat()

Reads per-model config from `ai.settings` → `models.anythingllm.chat.<model_id>` to get
`chat_endpoint`. Normalizes a `ChatInput` into `[{role, content, images[]}]` (images become
`{name, mime, contentString: data:…;base64,…}`), generates a `session_id` (from `$this->sessionId`
or a `Crypt::hashBase64(uniqid…)`), and builds a payload `{model, messages, stream, temperature: 0.7,
session_id} + $this->configuration`. `AnythingllmApi::chat()` then dispatches by endpoint:

- `chat_endpoint == 'anythingllm'` → `chatAnythingllm()` (`POST workspace/<model>/chat`, mode `chat`).
- `chat_endpoint == 'anythingllm_query'` → `chatAnythingllm(..., 'query')`.
- otherwise → `chatOpenai()` (`POST openai/chat/completions`, OpenAI-compat).

The native path sends only the **last** message's content + attachments (no history) and reshapes the
`textResponse` into an OpenAI-style `choices[0].message`. Non-streamed → a `ChatMessage`; streamed →
`AnythingllmChatMessageIterator` (wraps the single response array and yields `StreamedChatMessage`
from `choices[0].message`).

### Endpoint choice (`loadModelsForm()`)

For `chat` the provider adds a `chat_endpoint` radio (Anything LLM Chat / Anything LLM Query / OpenAI
compatibility mode; default `openai`). Anything LLM modes support images/files but no history; OpenAI
mode supports history but no images/files.

## embeddings()

`POST openai/embeddings` with `{inputs: [text], model}`; returns
`EmbeddingsOutput($response['data'][0]['embedding'], …)`.

## ai_search_api operations (used by the Search API backend)

The provider implements the store/search/delete side of RAG search — see
[search_backend.md](search_backend.md) for the indexing flow. Key methods:

- `storeText($content, $filename, $meta, $index_name, $model_id)` — create folder
  `drupal_search_api_<index>`, delete any prior doc, `POST document/raw-text`, move the file into the
  folder, then embed it into the workspace (`updateEmbedding`).
- `storeDocument($document, …)` — same but multipart file upload (`file_get_contents($document)` on
  the file URI) via `POST document/upload`.
- `storeLink($link, …)` — `POST document/upload-link`.
- `deleteDocuments()` / `deleteIndex()` — remove embeddings then remove documents/folder.
- `searchDocuments($collection, $search_words, …)` — builds the prompt (custom `message` with
  `{search_words}` or the raw words), reads `top_n`/`score_threshold` from the model config, and calls
  `AnythingllmApi::vectorSearch()` (`POST workspace/<model>/vector-search` with `query/topN/
  scoreThreshold`), returning `results`.
- `checkFilters(QueryInterface, $match)` → `processConditionGroup()` — evaluates Search API
  condition groups (AND/OR, nested) against the JSON `metadata.description` **in PHP after** results
  return (AnythingLLM does not filter server-side). Handles single- and multi-value fields with
  IN/NOT IN/=/<>/</<=/>/>=/BETWEEN operators.

## The API client (`AnythingllmApi`)

Service `ai_provider_anythingllm.api`. `setConnection()` loads `api_url` + resolves `api_key` via
`key.repository`. `call($endpoint, $method, $json, $file)` throws if key/url missing, sets
`Authorization: Bearer <key>`, JSON- or multipart-encodes the body, targets
`api_url . '/api/v1/' . $endpoint`, and returns the response body (swallowing exceptions → `'[]'`).
Wrapper methods: `chat`, `embeddings`, `vectorSearch`, `getModels`, `getDocuments`,
`createFolder`/`removeFolder`, `moveFile`, `removeDocuments`, `uploadText`/`uploadLink`/
`uploadDocument`, `updateEmbeddings`. TLS verification is at the Guzzle default (on); the base host is
whatever an `administer ai providers` admin set in `api_url`.
