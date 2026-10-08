# Configure: REST / JSON:API / Files storage clients

Storage clients are the data sources of an external entity type; they live under
`data_aggregator.config.storage_clients.<key>.{id,config}`. This module ships three native ones.
(The SQL client is in the `xnttsql` submodule.)

## `rest` — REST API client

Plugin `rest` (`Plugin/ExternalEntities/StorageClient/RestClient`, implements `RestClientInterface`,
extends `StorageClientBase`). Uses Drupal's core `http_client` (Guzzle) service. Config keys
(`defaultConfiguration()` / schema `plugin.plugin_configuration.external_entities_storage_client.rest`):

| Key | Purpose |
|---|---|
| `endpoint` | Main list URL (required). Drupal tokens are replaced; query string is moved to `parameters`. |
| `endpoint_options.single` | URL for one entity; use `{id}` placeholder (URL-encoded). Blank → `endpoint/{id}`. |
| `endpoint_options.count` | URL (or static integer) returning the total; `count_mode` = `entities`\|`pages`. |
| `endpoint_options.dynamic_count` | Determine total by paging until a short page (unfiltered only). |
| `endpoint_options.cache` | The list endpoint returns full entities (skip per-id fetches). |
| `endpoint_options.limit_qcount` / `limit_qtime` | Rate-limit N queries per T seconds (tracked in `xntt_rest_queries`). |
| `endpoint_options.concurrency` | Parallel Guzzle requests when loading entities individually (1–50, default 5). |
| `response_format` | Decoder id (`json`, plus any registered `external_entity_response_decoder`). |
| `data_path.list` / `.single` / `.count` | JSONPath into wrapped responses (e.g. `$.data.*`). |
| `data_path.keyed_by_id` | List is keyed by id rather than a plain array. |
| `pager.*` | `default_limit`, `page_parameter`(+`_type` `pagenum`\|`startitem`), `page_size_parameter`(+`_type`), `page_start_one`, `always_query`. |
| `api_key.type` | `none` \| `bearer` \| `custom` \| `query`; with `header_name` + `key`. |
| `http.headers` | Extra HTTP headers (one `Name: value` per line; tokens replaced). |
| `parameters.list` / `.single` (+`_param_mode` `query`\|`body`\|`body_query`) | Extra query/body params; `{id}` replaced for single. |
| `filtering.drupal` | Allow Drupal-side filtering of unsupported filters (may fetch everything — slow). |
| `filtering.basic` / `basic_fields` / `list_support` / `list_join` | Source-side equality filtering on mapped fields. |

Authentication: `bearer` auto-prefixes the key with `Bearer ` and sets header `Authorization`;
`custom` sends `header_name: key`; `query` appends `header_name=key` to the URL. On save the form warns
if authentication is set while any endpoint URL is not `https://`. TLS verification uses core defaults.

Runtime (`StorageClientInterface`): `load()`, `loadMultiple()`, `save()`, `delete()`, `query()`,
`querySource()`, `countQuery()`, `countQuerySource()`, `isCountable()`. Drupal field names/operators
are translated to source parameters by `transliterateDrupalFilters()` / `transliterateDrupalSorts()`.

## `jsonapi` — Drupal JSON:API client

Plugin `jsonapi` (`StorageClient/JsonApi`) derives from `rest` (schema reuses the `rest` mapping) and
adds JSON:API field-filtering conventions for endpoints served by Drupal's core JSON:API.

## `files` — file-system client

Plugin `files` (`StorageClient/Files`, extends `FileClientBase`, implements `FileClientInterface`).
Treats files in a directory as entities. Config keys (schema
`...storage_client.file_base` / `.files`): `root` (base directory), `structure` (file name/pattern),
`matching_only`, `record_type` (single vs multi record per file), `save_mode`,
`performances.use_index` + `performances.index_file`, `data_fields.field_list`, `md5_checksum`,
`sha1_checksum`. An index file can be (re)built via the batch callbacks
`external_entities_regenerate_index_file_process()` / `_finished()` in the `.module`.

## Notes

- `endpoint`/`single`/`count` URLs are administrator-configured; the entity `id` is URL-encoded into
  the path, filter values go through query/body parameters.
- Set `debug_level` on the external entity type to log HTTP requests (a debug Guzzle client,
  `external_entities.rest.debug_client`, is swapped in) — level 1 logs method/URI/status, ≥2 also
  logs request options and response bodies.
