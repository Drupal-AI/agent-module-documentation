<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Vragen.ai (search_api_vragen_ai) — agent index

Provides a **Search API backend** (`vragen_ai`) that indexes Drupal content into the hosted
[Vragen.ai](https://www.vragen.ai/) semantic-search service and runs full-text, "more like this"
and faceted searches against it over its JSON:API. You configure it entirely through Search API's
normal **Server** + **Index** admin UI (`/admin/config/search/search-api`) — there is no dedicated
settings page or route. On the server you enter the Vragen.ai **API endpoint** and **Bearer token**;
the backend builds an authenticated Guzzle client (base URI + `Authorization: Bearer …` header) via
its own `ClientFactory` and talks to `documents/*` and `systems/*` endpoints. Indexing maps each
Search API item to a Vragen.ai *document* (external reference = the item id minus its langcode);
selected fields become the semantic HTML `content`, other fields become `meta_data`, and PDF
attachments (from file/media references) are sent as `attachments` for server-side extraction.

Search results are cached in Drupal's cache backend with a TTL (default 3600s, key `search_cache_ttl`)
and invalidated only by TTL, never by indexing. Query building is split into `FilterService`,
`FacetService` and `SortService` which translate Search API condition groups/sorts/facets into
Vragen.ai query params. A **Views display extender** exposes per-display `alpha`/`max_distance`/
`distance` tuning for hybrid (semantic vs keyword) search.

- Depends on: `search_api:search_api`. Composer: `php >=8.1`, `drupal/search_api:^1.0`,
  `swisnl/json-api-client:^2.4` (the JSON:API client library the backend is built on).
- Core: `^10.1 || ^11 || ^12`. Package: `Search`. Version documented: **2.0.4**.
- No `configure` route, **no permissions, no drush, no routing/menu links, no controllers**. All
  admin surface is Search API's Server/Index/Processor forms + a Views display extender.
- Provides config schema (backend, processor, views display extender). The legacy
  `search_api_vragen_ai.settings` config object and `/admin/config/search/vragen-ai` form were
  **removed** — global settings are migrated into per-server `backend_config` by `update_8001`.
- Plugin **ids** (not new plugin *types* — these extend Search API's types): backend `vragen_ai`,
  processors `vragen_ai_semantic_content` + `vragen_ai_attachment_files`, data type
  `vragen_ai_attachment`, Views display extender `search_api_vragen_ai_display_extender`.

## What you'd do → where

- **Set up the server: endpoint, bearer token, search system, multisite, caching, hybrid tuning** →
  [configure/server.md](configure/server.md)
- **Set up the index: datasources, which fields are semantic content vs metadata, PDF/file
  attachments, languages, delete/translation behavior** → [configure/indexing.md](configure/indexing.md)
- **Look up a plugin id / class / supported feature / data type** → [plugins/plugins.md](plugins/plugins.md)
- **Call the Vragen.ai client from PHP, or understand the request/DTO/endpoint/cache-key shape** →
  [api/client.md](api/client.md)
- **Alter or veto a document before it is indexed (e.g. the bundled PDF-media handling)** →
  [events/events.md](events/events.md)

## Key facts (real machine names)

- Backend: `vragen_ai` — `Plugin\search_api\backend\VragenAiBackend` (`@SearchApiBackend`). Supported
  features: `search_api_mlt`, `search_api_facets`, `search_api_facets_operator_or`. Supported data
  type: `vragen_ai_attachment`.
- Processors: `vragen_ai_semantic_content` (`VragenAiSemanticContent`, stage `preprocess_index`),
  `vragen_ai_attachment_files` (`VragenAiAttachmentFiles`, stage `preprocess_index`).
- Data type: `vragen_ai_attachment` (`VragenAiAttachmentType`, `fallback_type = string`).
- Views display extender: `search_api_vragen_ai_display_extender` (`SearchApiVragenAiDisplayExtender`) —
  registered into `views.settings:display_extenders` by `hook_install` / `update_8007` / `update_8008`.
- Services: `search_api_vragen_ai.client_factory` = `Client\ClientFactory`
  (args `@http_client_factory`, `@cache.default`; also aliased by FQCN);
  `search_api_vragen_ai.index_events_subscriber` = `EventSubscriber\IndexEventsSubscriber`;
  `search_api_vragen_ai.mapping_events_subscriber` = `EventSubscriber\MappingEventsSubscriber`.
- Event: `Event\PostCreateIndexDocumentEvent` (`getItem()`, `getDocument()`, `getIndex()`,
  `shouldIndex(?bool)`).
- Backend config keys (`backend_config`): `api_endpoint`, `api_token`, `search_system`
  (deprecated `default_search_system`), `multisite_prefix` (bool), `language_fallback` (bool),
  `search_cache_ttl` (int, no UI), `alpha`, `max_distance`, `distance` (floats).
- Client class constant `Client::DEFAULT_SEARCH_CACHE_TTL = 3600`. Client cache key =
  `sha1($endpoint . '|' . $token)`. Cache tags: `search_api_vragen_ai_client:<cacheKey>`,
  `search_api_vragen_ai_systems`.
- API endpoints hit: `documents` (list/create/update/delete), `documents/search`,
  `documents/similar`, `systems` (list), `systems/{id}/search`. Requested fieldset:
  `external_reference,relevance_score,metadata_fields`.
- Update hooks: `8001`–`8008` (`.install`) migrate legacy global settings → server config, drop an
  obsolete permission, rename `default_search_system`→`search_system`, add `language_fallback` /
  `alpha` / `distance` / `max_distance` defaults, downgrade legacy `vragen_ai_metadata` fields to
  `string`, and (re)register the Views display extender.
