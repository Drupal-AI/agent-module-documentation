# Configure the server (backend config)

The backend has no dedicated route. Create a Search API **Server** at
`/admin/config/search/search-api/add-server` and pick backend **Vragen.ai** (`vragen_ai`). The form
is built by `VragenAiBackend::buildConfigurationForm()`. All values land in the server config entity
`search_api.server.<id>` under `backend_config`.

## Form fields → config keys

| Form field | Key in `backend_config` | Type | Notes |
|---|---|---|---|
| API Endpoint | `api_endpoint` | string | Required. Placeholder `https://[account].vragen.ai/api/v1`. A trailing `/` is normalized on/off in `ClientFactory`. Base URI of every request. |
| API Bearer Token | `api_token` | string | Required. Sent as the `Authorization: Bearer <token>` header on every request. Held in the server's `backend_config`. |
| Search System | `search_system` | string | UUID of a Vragen.ai "searchSystem". Populated by an AJAX-loaded `<select>` once endpoint+token are valid; empty = search without a system. Legacy key `default_search_system` is deprecated and renamed by `update_8003`. |
| Multisite support | `multisite_prefix` | bool (default FALSE) | See below. |
| Language fallback | `language_fallback` | bool (default TRUE) | See below. |
| Alpha value | `alpha` | float 0–1 | Hybrid weighting: `1` = purely semantic, `0` = purely keyword. Empty = Vragen.ai default. |
| Max distance value | `max_distance` | float 0–1 | Drops results whose semantic distance is too large (lower = stricter). Empty = no limit. Applied to normal search. |
| Distance value | `distance` | float 0–1 | Same idea, applied to "more like this" (`similar`) queries. |
| *(no UI)* | `search_cache_ttl` | int | Result cache TTL in seconds. Default `Client::DEFAULT_SEARCH_CACHE_TTL` = 3600. Set only via exported config / a recipe. |

Schema: `config/schema/search_api_vragen_ai.backend.schema.yml`
(`plugin.plugin_configuration.search_api_backend.vragen_ai`).

## AJAX "Search System" dropdown

`api_endpoint` and `api_token` both declare an `#ajax` callback `VragenAiBackend::updateSystemsDropdown`
firing on `change`. On rebuild the backend instantiates a client with the *current* form values and
calls `->systems()->cachedAllByType('searchSystem', TRUE)`. On failure it shows
`Vragen.ai connection credentials are invalid.`; otherwise the select is filled with
`uuid => tag|name|id`. Empty endpoint/token shows `Enter endpoint and token to load search systems.`
This is the connectivity check — there is no separate "test connection" button. `isAvailable()`
(server status) likewise calls `systems()->all()`.

## Multisite prefixing (`multisite_prefix`)

When several sites of one Drupal multisite share the same Vragen.ai account, external references like
`entity:node/1` collide. Enabling this prefixes references with the site identifier
(`basename(site.path)`, e.g. `site_a:entity:node/1`). Implemented in
`getExternalReferencePrefix()` / `prefixExternalReference()`; the `default` site never gets a prefix,
so the option is a no-op on single-site installs. `reconstructItemId()` strips the prefix on read and
returns `NULL` for documents belonging to another site. **Changing this requires reindexing all
content** (existing documents keep their old references).

## Caching (`search_cache_ttl`)

`search()` and `similar()` results are cached (`cache.default`) under a deterministic id
`search_api_vragen_ai:<search|similar>:<cacheKey>:sha1(serialize(params))`, tagged
`search_api_vragen_ai_client:<cacheKey>`. Invalidation is **TTL-only** — indexing or deleting items
does not flush cached results, so the TTL is the maximum staleness window. `Client::clearCache()`
invalidates that tag but is not wired to any indexing hook. Lower `search_cache_ttl` for frequently
changing content.

## Language fallback (`language_fallback`)

Default TRUE. When FALSE, `addLanguageCondition()` adds an OR condition group restricting the query to
the request's languages, and `reconstructItemId()` maps results to `:und` when no preferred language
matches. When TRUE, results fall back to the document's `canonical_language` (or first indexed
language). This only affects which translation a result is mapped back to — content still leaves to
Vragen.ai regardless.
