<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories (localgov_directories) — agent index

Facet-filtered directories for LocalGov Drupal: `localgov_directory` **channel** nodes + entry
nodes + a `localgov_directories_facets` content entity, all served through a Search API index and
the Facets module. Config UI `/admin/config/…` via
`entity.localgov_directories_facets_type.collection`; facet values live at
`/admin/content/directories/facets`.

- **Setup: channel/entry/facet wiring, the index, required submodules** →
  [configure/setup.md](configure/setup.md)
- **Entities, constants, hooks and the Facets/Search API integration** →
  [api/architecture.md](api/architecture.md)
- **Permissions and the LocalGov default-roles integration** →
  [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `localgov_directories_db` → [../../modules/localgov_directories_db/3.5.x/agent/start.md](../../modules/localgov_directories_db/3.5.x/agent/start.md)
- `localgov_directories_page` → [../../modules/localgov_directories_page/3.5.x/agent/start.md](../../modules/localgov_directories_page/3.5.x/agent/start.md)
- `localgov_directories_venue` → [../../modules/localgov_directories_venue/3.5.x/agent/start.md](../../modules/localgov_directories_venue/3.5.x/agent/start.md)
- `localgov_directories_org` → [../../modules/localgov_directories_org/3.5.x/agent/start.md](../../modules/localgov_directories_org/3.5.x/agent/start.md)
- `localgov_directories_promo_page` → [../../modules/localgov_directories_promo_page/3.5.x/agent/start.md](../../modules/localgov_directories_promo_page/3.5.x/agent/start.md)
- `localgov_directories_location` → [../../modules/localgov_directories_location/3.5.x/agent/start.md](../../modules/localgov_directories_location/3.5.x/agent/start.md)
- `localgov_directories_or` / `localgov_directories_venue_or` (Open Referral, experimental) →
  [../../modules/localgov_directories_or/3.5.x/agent/start.md](../../modules/localgov_directories_or/3.5.x/agent/start.md)

Key facts:
- **Entities:** content entity `localgov_directories_facets` (base table
  `localgov_directories_facets`, data table `…_field_data`, translatable, bundle entity
  `localgov_directories_facets_type`, admin permission `administer directory facets types`,
  links under `/admin/content/directories/facets`). Facet **values are content, not config** —
  editors create them in production and they are excluded from config export by design.
- **Node types:** `localgov_directory` (the channel) ships in `config/install`; entry bundles come
  from submodules. An entry is any node with the `localgov_directory_channels` reference field.
- **Key fields** (see `src/Constants.php`): `localgov_directory_channels` (entry → channel),
  `localgov_directory_channel_types` (channel → allowed entry bundles),
  `localgov_directory_facets_enable` (channel → enabled facet types),
  `localgov_directory_facets_select` (entry → chosen facet values),
  `localgov_directory_facets_filter` (indexed field the facets actually query),
  `localgov_directory_title_sort`, `localgov_location` (+ `localgov_location_wkt`),
  `localgov_proximity_search_cfg`.
- **Search API:** index `localgov_directories_index_default`; the DB server comes from the
  `localgov_directories_db` submodule. Swap in Solr by disabling that submodule first.
- **View:** `localgov_directory_channel` with displays `node_embed`,
  `node_embed_for_proximity_search`, `embed_map`.
- Facets integration: processors `LocalGovDirectoriesProcessor` and `WeightOrderProcessor`, query
  type `LocalGovDirectoriesQueryType`, a BEF checkbox plugin, plus templates for facet lists and
  checkboxes. `hook_facets_facet_insert()`, `hook_field_config_insert/delete()` and
  `hook_search_api_index_update()` keep index/facet config in sync as types are added or removed.
- `config/conditional/` holds facet config applied only when the relevant modules are present;
  `config/optional/` holds blocks, pathauto pattern and autocomplete config.
