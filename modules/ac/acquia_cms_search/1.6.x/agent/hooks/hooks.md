# Hooks (acquia_cms_search)

The module has no public service API — its integration points are hook implementations in
`acquia_cms_search.module` / `.install` that react to entity and module events and delegate to three
internal facades (`Drupal::classResolver(...)`). The facades are marked `@internal` ("External code
should not use this class"), so integrate through config/third-party settings, not by calling them.

## Entity-reaction hooks (auto-wiring the index)

| Hook | What it does | Delegates to |
|---|---|---|
| `hook_ENTITY_TYPE_insert` — `node_type` | Adds a newly created node type to the index named in its `acquia_cms_common.search_index` third-party setting (datasource bundle, `rendered_item` view mode, `search` view teaser row). | `SearchFacade::addNodeType()` |
| `hook_ENTITY_TYPE_insert` — `field_config` | Tags `node.body` with `search_index=content` / `search_label=Body`; indexes taxonomy-term reference fields (id + `_name`); indexes `datetime`/`string`/`email`/`telephone`/`address`/`text_with_summary` fields with a mapped Search API type. | `SearchFacade::addTaxonomyField()`, `SearchFacade::addFields()` |
| `hook_entity_insert` (any entity) | Calls `search_api.post_request_indexing->destruct()` so content created programmatically (e.g. tests) is indexed immediately. | core service |
| `hook_ENTITY_TYPE_insert` — `search_api_server` | For each disabled index whose `acquia_cms_common.search_server` third-party setting equals this server, attaches the server, enables the index, and removes the (now-consumed) setting. Skipped during config sync. | inline |
| `hook_ENTITY_TYPE_update` — `search_api_server` | If `acquia_search` is present and the saved server is an Acquia server (`Runtime::isAcquiaServer`), runs the Solr switch-over. | `AcquiaSearchFacade::submitSettingsForm()` |

All the facade writes bail out when `config.installer` / `Drupal::isConfigSyncing()` reports a sync in
progress, to avoid unintended secondary config writes during import.

## Config-schema and form hooks

- `hook_config_schema_info_alter` — adds a `search_index` string key to
  `node.type.*.third_party.acquia_cms_common` so node types may carry the opt-in setting.
- `hook_form_FORM_ID_alter` for `acquia_cms_search_form` — appends
  `AcquiaSearchFacade::submitSettingsForm` to `#submit` (the Solr switch-over on the Tour form).

## Views hooks

- `hook_views_data` — registers the `view_fallback` area handler.
- `hook_views_plugins_query_alter` — when `facets_pretty_paths` is enabled, replaces the
  `search_api_query` handler class with this module's `SearchApiQuery` (adds `url.path` cache context).
- `hook_views_plugins_cache_alter` — a backward-compat shim that aliases `search_api_none_bc` to
  `search_api_none` on older search_api. See [views/views.md](../views/views.md).

## Module-install hooks

- `hook_modules_installed` → `_acquia_cms_search_add_category_facet()` — when any of
  `acquia_cms_person`, `acquia_cms_place`, `acquia_cms_article`, `acquia_cms_event`, `acquia_cms_page`
  is installed, creates the `search_category` facet (field `field_categories`, url alias `category`)
  via `FacetFacade::addFacet()` if it does not already exist.
- `hook_install` — grants `use search_api_autocomplete for search` to `anonymous` and `authenticated`;
  retroactively runs `addNodeType()` over existing node types; adds the category facet.
- `hook_module_preinstall` — records the preinstall trigger on `acquia_cms_common.utility`.
- `hook_update_8001` / `hook_update_8002` — enforce the module dependency on the shipped Site Studio
  view templates and delete any that contain invalid data (only when `acquia_cms_site_studio` exists).

## Facade reference (internal)

- `SearchFacade` — `addNodeType()`, `addTaxonomyField()`, `addFields()`; constructed via
  `create()` from `config.installer`, index/view/field_config storages, `search_api.fields_helper`.
- `AcquiaSearchFacade` — static `submitSettingsForm()`; protected `isConfigured()`,
  `switchIndexToSolrServer()`, `ensureActiveSubscription()`. Reads `acquia_search.settings:api_host`
  and `acquia_connector.*` state, uses `acquia_connector.subscription`.
- `FacetFacade` — `addFacet()`, `defaultValues()`, `mergeValues()`; encodes the default facet
  widget/processor config used for `search_category`.
