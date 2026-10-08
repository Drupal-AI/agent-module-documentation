<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front-end search block & InstantSearch

Search results are rendered client-side with Typesense InstantSearch.js, not via Views or a
server-side query. The libraries are declared in `search_api_typesense.libraries.yml`:

- `instantsearch` — CDN scripts: `typesense-instantsearch-adapter@2`, `algoliasearch@4.20.0`,
  `instantsearch.js@4.60.0`.
- `search` — `js/search.js` + `instantsearch.css` theme + `css/search.css` (deps: jquery, once,
  the `instantsearch` library).
- `converse` — `js/converse.js` + `css/converse.css`.

## Block plugin

`Drupal\search_api_typesense\Plugin\Block\TypesenseSearchBlock`
(`id = search_api_typesense_search_block`, category "Typesense"). `blockAccess()` = `access content`.

- `blockForm()`: select a Typesense **server**, AJAX-load its **collections** (checkboxes; multiple =
  federated/multi-index search), enter a **search-only API key**, set **hits_per_page** (1–100).
- `validateConfigurationForm()`: for multiple collections, verifies all selected collections share the
  same facet fields (federated search requires matching facets).
- `blockSubmit()` stores `server`, `collections`, `hits_per_page`, `search_only_key`.
- `build()` validates the backend, loads the indexes, and builds the render array via the render
  service, passing the configured **search-only key** as the client `apiKey`. Cache tags include the
  server, each index/schema config, and `search_api_typesense.settings`.

Config schema: `block.settings.search_api_typesense_search_block` (server, collections[],
hits_per_page, search_only_key).

## Render service

`Render\TypesenseSearchRenderService` (service `search_api_typesense.render_service`, implements
`…RenderServiceInterface`). `buildSearchRender(TypesenseSearchRenderContext $context)` builds a
`search_api_typesense_search` themed render array and attaches `drupalSettings.search_api_typesense.
blocks[<uuid>]` with:

- `server.apiKey` (the context's API key — the **search-only** key for the block),
- `server.nodes` from `retrievePublicNodes()` (the configured `public_endpoint`, else `nodes`),
- `collection_specific_search_parameters` (query_by, query_by_weights, sort_by),
- `collection_render_parameters`, `facets`, `hits_per_page`, optional `current_langcode`/`debug`.

Dispatches `SearchRenderEvent` to allow altering the render array. `validateBackend()` asserts the
server uses `SearchApiTypesenseBackend`. Context object:
`Render\TypesenseSearchRenderContext`.

## Admin preview routes

- **Search** (`TypesenseIndexController::search`) — renders the InstantSearch preview using the
  per-server search-only key from `search_api_typesense.search_keys` (resolved by `resolveApiKey()`;
  prompts via `Form\SearchOnlyKeyConfigForm` if none set).
- **Converse** (`TypesenseIndexController::converse`) — renders the conversational UI (`converse.js`)
  against a Typesense conversation model; requires the `ai` module + a supported provider
  (`AiModels::isAiSupportAvailable()`). Admin-only route (`administer search_api`).

## AI models

`AiModels` (service `search_api_typesense.ai_models`) enumerates embedding models (Typesense built-in
`ts/…` from `search_api_typesense.settings` plus AI-provider models for openai/litellm) and
conversation models, and resolves provider API keys via the `key` repository
(`AiModels::getKeyValue()`). Used by the schema form (embedding) and the converse flow.
