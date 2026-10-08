<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture: entities, constants, hooks, plugins

## Constants (`src/Constants.php`) — the contract

Everything else keys off these; read them rather than hard-coding strings.

| Constant | Value |
|---|---|
| `DEFAULT_INDEX` | `localgov_directories_index_default` |
| `CHANNEL_NODE_BUNDLE` | `localgov_directory` |
| `CHANNEL_VIEW` / `CHANNEL_VIEW_DISPLAY` | `localgov_directory_channel` / `node_embed` |
| `CHANNEL_VIEW_PROXIMITY_SEARCH_DISPLAY` / `CHANNEL_VIEW_MAP_DISPLAY` | `node_embed_for_proximity_search` / `embed_map` |
| `CHANNEL_SELECTION_FIELD` | `localgov_directory_channels` |
| `FACET_SELECTION_FIELD` | `localgov_directory_facets_select` |
| `FACET_INDEXING_FIELD` | `localgov_directory_facets_filter` |
| `FACET_CONFIG_ENTITY_ID` / `_TYPE_CONFIG_ENTITY_ID` | `localgov_directories_facets` / `localgov_directories_facets_type` |
| `FACET_CONFIG_FILE` | `facets.facet.localgov_directories_facets` |
| `FACET_CONFIG_ENTITY_ID_FOR_PROXIMITY_SEARCH` | `localgov_directories_facets_proximity_search` |
| `TITLE_SORT_FIELD` | `localgov_directory_title_sort` |
| `LOCATION_FIELD` / `LOCATION_FIELD_WKT` | `localgov_location` / `localgov_location_wkt` |
| `PROXIMITY_SEARCH_CFG_FIELD` | `localgov_proximity_search_cfg` |
| `CHANNEL_SEARCH_BLOCK` | `localgov_directories_channel_search_block` |
| `FACET_EMPTY_CLASS` | `facet-empty` |
| `SEARCH_API_LOCATION_DATATYPE` | `location` |

```php
use Drupal\localgov_directories\Constants;
$index_id = Constants::DEFAULT_INDEX;
```

## The facets entity

```php
@ContentEntityType(
  id = "localgov_directories_facets",
  base_table = "localgov_directories_facets",
  data_table = "localgov_directories_facets_field_data",
  translatable = TRUE,
  bundle_entity_type = "localgov_directories_facets_type",
  admin_permission = "administer directory facets types",
  entity_keys = { id, langcode, bundle, label = "title", uuid, weight },
  field_ui_base_route = "entity.localgov_directories_facets_type.edit_form",
)
```

Handlers: `EntityViewBuilder`, `LocalgovDirectoriesFacetsListBuilder`, `EntityViewsData`,
`LocalgovDirectoriesFacetsAccessControlHandler`, add/edit form
`LocalgovDirectoriesFacetsForm`, delete form `ContentEntityDeleteForm`, `AdminHtmlRouteProvider`.
The `weight` entity key is what `WeightOrderProcessor` sorts facet items by.

```php
$storage = \Drupal::entityTypeManager()->getStorage('localgov_directories_facets');
$facet   = $storage->create(['bundle' => 'size', 'title' => 'Large', 'weight' => 0]);
$facet->save();
```

## Hooks the module implements

| Hook | Purpose |
|---|---|
| `hook_theme()` | `localgov_directories_facets`, facet item-list and checkbox templates, `bef_checkboxes_directory_facets` |
| `hook_localgov_roles_default()` | Grants the LocalGov **editor** role facet CRUD + `localgov_directory` node permissions |
| `hook_modules_installed()` | When `localgov_services_navigation` arrives, installs the optional `localgov_services_parent` field and applies optional field settings |
| `hook_entity_extra_field_info()` / `hook_ENTITY_TYPE_view()` | Delegate to `DirectoryExtraFieldDisplay` — renders the channel's embedded view, map and search block as pseudo-fields |
| `hook_pathauto_pattern_alter()` | Adds the optional service parent into directory paths |
| `hook_field_config_insert()` / `hook_field_config_delete()` | Keep the Search API index fields in step as facet/channel fields appear and disappear |
| `hook_facets_facet_insert()` | Wire a newly created facet into the directory configuration |
| `hook_search_api_index_update()` | Re-sync facet config when the index changes |
| `hook_preprocess_facets_item_list()` / `hook_theme_suggestions_checkboxes_alter()` | Group facet items by type, add the `facet-empty` class, pick directory-specific templates |
| `hook_form_facets_form_alter()` | Adjust the Facets admin form for directory facets |
| `hook_leaflet_map_view_style_alter()` | Tune the Leaflet map settings for channel maps |
| `hook_facets_search_api_query_type_mapping_alter()` | Map the directory query type onto the active backend |

All hooks are procedural in `localgov_directories.module`, several delegating to
`class_resolver`-instantiated services (`DirectoryExtraFieldDisplay`, `ConfigurationHelper`).

## Plugins provided

| Type | Plugin | Purpose |
|---|---|---|
| Block | `localgov_directories_channel_search_block` (`ChannelSearchBlock`) | Keyword search scoped to the channel; requires a `node` context |
| Facets processor | `LocalGovDirectoriesProcessor` | Directory-aware facet building |
| Facets processor | `WeightOrderProcessor` | Orders facet items by the facet entity's `weight` |
| Facets query type | `LocalGovDirectoriesQueryType` | Query type used against the directory index |
| Search API processor | `TitleSortField` | Maintains the normalised `localgov_directory_title_sort` value |
| Entity reference selection | `LocalgovDirectoriesChannelsSelection`, `LocalgovDirectoriesEntryTypes`, `LocalgovDirectoriesFacetsSelection` | Limit reference options to valid channels / entry bundles / facets |
| Field widget | `ChannelFieldWidget`, `FacetFieldWidget`, `ChannelFacetInteractions` | Channel + facet selection UX on the entry form |
| BEF filter | `DirectoryFacetsCheckboxes` | Better Exposed Filters rendering of directory facets |
| Preview link | `DirectoryChannel` | Autopopulate preview links for a channel |

## Config layout

- `config/install/` — the `localgov_directory` node type, its fields/displays, the Search API
  index, the channel view.
- `config/conditional/` — facet config (`facets.facet.localgov_directories_facets` and the
  proximity variant) applied when the relevant modules are present; `DirectoriesConfigSubscriber`
  and `ConfigurationHelper` manage this.
- `config/optional/` — block placements, pathauto pattern, autocomplete, the
  `localgov_services_parent` field and a menu-link group.

Because facet **values** are content, exporting config captures facet *types* but not the values —
that is intentional, so production editors own the vocabulary.
