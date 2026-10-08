# Plugin ids (Search API + Views)

This module defines **no new plugin types**; it provides implementations that plug into Search API's
and Views' existing plugin types. All ids below are real machine names.

## Backend — `vragen_ai`

`Plugin\search_api\backend\VragenAiBackend` (`@SearchApiBackend(id = "vragen_ai")`), extends
`BackendPluginBase implements PluginFormInterface`.

- `getSupportedFeatures()` → `search_api_mlt`, `search_api_facets`, `search_api_facets_operator_or`.
- `supportsDataType('vragen_ai_attachment')` → TRUE.
- Config form + keys: see [../configure/server.md](../configure/server.md).
- Notable methods: `indexItems()`/`indexItem()`, `deleteItems()` (translation-aware),
  `deleteAllIndexItems()` (no-op), `search()` (handles the `server_index_status` tag, normal search,
  and `search_api_mlt`), `isAvailable()`. `__sleep()` drops the lazy `client` property from
  serialization.
- The special query tag `server_index_status` returns just the remote document count
  (`documents()->all()->getMeta()->page->total`).

## Processor — `vragen_ai_semantic_content`

`Plugin\search_api\processor\VragenAiSemanticContent` (stage `preprocess_index` = 0). Lets the admin
choose which fields become semantic document `content`. Config `fields` (field-id sequence).
`supportsIndex()` only TRUE on a `vragen_ai` server. Constants `SUPPORTED_PLAIN_FIELD_TYPES =
['text','string','integer']`, `SUPPORTED_BOOLEAN_FIELD_TYPES = ['boolean']`. See
[../configure/indexing.md](../configure/indexing.md).

## Processor — `vragen_ai_attachment_files`

`Plugin\search_api\processor\VragenAiAttachmentFiles` (stage `preprocess_index` = 0). Populates
`vragen_ai_attachment` fields from file/media references (recursive, cycle-protected). Injects
`file_url_generator`. `supportsIndex()` only TRUE on a `vragen_ai` server.

## Data type — `vragen_ai_attachment`

`Plugin\search_api\data_type\VragenAiAttachmentType` (`@SearchApiDataType`, `fallback_type = string`,
`default = false`). Marks a field as carrying attachment references. `MappingEventsSubscriber` maps it
to `string` / `search_api_text` for Views field-type, field-handler and handler mapping so it can be
used and filtered in Views.

## Views display extender — `search_api_vragen_ai_display_extender`

`Plugin\views\display_extender\SearchApiVragenAiDisplayExtender` (`#[ViewsDisplayExtender]`,
`no_ui: FALSE`). Adds a **Vragen.ai** category with a "Query settings" section to Search API Views
displays, exposing per-display options `alpha`, `max_distance`, `distance` (each `0–1`, step `.01`).

- `query()` copies each option onto the `SearchApiQuery` via `$query->setOption($key, …)`; the backend
  then reads `$query->getOption('alpha'|'max_distance'|'distance')`, overriding the server config
  default when set.
- `applies()` returns TRUE only when the view's base table is a `search_api_index_*` whose server
  backend is a `VragenAiBackend`.
- Config schema: `views.display_extender.search_api_vragen_ai_display_extender` (`alpha`,
  `max_distance`, `distance` floats). Registered into `views.settings:display_extenders` by
  `hook_install`, re-asserted by `update_8007`/`update_8008`, removed by `hook_uninstall`.
