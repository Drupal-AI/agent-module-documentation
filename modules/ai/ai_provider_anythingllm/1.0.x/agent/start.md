<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnythingLLM Provider (ai_provider_anythingllm) — agent index

An **AI provider plugin + Search API backend** connecting the Drupal **AI (`ai`) module** to an
**AnythingLLM** instance (self-hostable LLM/RAG app). Package *AI Providers*. Depends on `ai:ai`,
`key:key`; requires `search_api` (`^1.34`) and the `league/html-to-markdown` + `league/commonmark`
libraries via Composer. Core `^10.2 || ^11`. License GPL-2.0-or-later. No permissions of its own,
no Drush, no submodules.

## What it provides

- **AI provider plugin** `AnythingllmProvider` (id **`anythingllm`**) in
  `src/Plugin/AiProvider/AnythingllmProvider.php`, extending `AiProviderClientBase`. Operation types:
  **`chat`**, **`embeddings`**, **`ai_search_api`** (custom). Models are workspaces fetched live from
  the AnythingLLM API (`hasPredefinedModels = FALSE`).
- **Custom operation type** `ai_search_api` — attribute + interface
  `src/OperationType/AiSearchApi/AiSearchApiInterface.php`; also registered as an AI operation type in
  `ai_provider_anythingllm.module` (`hook_ai_operation_types_alter`).
- **Search API backend** `SearchApiAiAnythingllmBackend` (id **`search_api_ai_anythingllm`**, label
  *"AI Search with AnythingLLM"*) in `src/Plugin/search_api/backend/`.
- **API client service** `ai_provider_anythingllm.api` (`AnythingllmApi`) — all HTTP calls to
  AnythingLLM's `/api/v1/` endpoints.
- **Item repository service** `ai_provider_anythingllm.repository` (`AnythingllmItemRepository`) —
  parameterized CRUD over the `ai_provider_anythingllm` DB table (schema in
  `ai_provider_anythingllm.install`) mapping a Search API item id → uploaded document names.
- **Stream iterator** `AnythingllmChatMessageIterator`.
- **Settings form** `AnythingllmConfigForm` at route **`ai_provider_anythingllm.settings_form`** →
  `/admin/config/ai/providers/anythingllm` (permission **`administer ai providers`**).
- **Config object** `ai_provider_anythingllm.settings` (`api_url`, `api_key`) with schema.
- **Hook** `hook_search_api_anythingllm_data_alter()` (documented in `ai_provider_anythingllm.api.php`).

## Docs

- **Connection settings, config, routes, DB schema, install** → [config/settings.md](config/settings.md)
- **Provider plugin: chat/embeddings, ai_search_api ops, the API client** →
  [plugins/provider.md](plugins/provider.md)
- **The Search API backend: indexing, search, access checks, filters** →
  [plugins/search_backend.md](plugins/search_backend.md)

## Key facts (from source)

- The AnythingLLM base URL is an **admin-set** config value (`api_url`, plain textfield, placeholder
  `http://127.0.0.1:3001`) — writable only with `administer ai providers`. The client appends
  `/api/v1/<endpoint>`; the API key is sent as `Authorization: Bearer …`, never in the URL.
- `AnythingllmApi::call()` uses the core Guzzle `http_client` with default TLS verification (on); no
  request option disables it.
- Search results are re-checked with `$entity->access('view', $currentUser)` per hit
  (`checkEntityAccess()`); indexed content is HTML→Markdown on the way in and Markdown→HTML
  (`html_input: strip`, `allow_unsafe_links: FALSE`) on the way out.
