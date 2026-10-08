<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, submodules, permissions and settings (suite setup)

DKAN is installed with Composer (`composer require drupal/dkan`) and behaves like a small distribution:
enabling the top-level `dkan` module pulls in its metastore/admin/search dependencies, and you then
enable the optional submodules you need. On this instance the enabled set is `dkan`, `dkan_common`,
`dkan_metastore`, `dkan_metastore_admin`, `dkan_metastore_search`, `dkan_data_dictionary_widget`;
`dkan_datastore`, `dkan_datastore_mysql_import`, `dkan_harvest`, `dkan_js_frontend`, `dkan_alt_api`,
`dkan_metastore_facets`, `dkan_sample_content` are optional add-ons (enable the ones a project uses).

## Which submodules to enable

| Need | Enable |
| --- | --- |
| Dataset catalog + JSON metadata API + `/data.json` | `dkan_metastore` (core; required by `dkan`) |
| Admin Views/toolbar for dataset content | `dkan_metastore_admin` |
| `/api/1/search` + faceted dataset search | `dkan_metastore_search` (+ `dkan_metastore_facets` for facet blocks) |
| CSV → queryable datastore + query/SQL/import API | `dkan_datastore` |
| Faster large-CSV import via `LOAD DATA` | `dkan_datastore_mysql_import` |
| Pull datasets from external `data.json` catalogs | `dkan_harvest` |
| Decoupled React/JS front end routing | `dkan_js_frontend` |
| Anonymous-vs-authenticated API permission variants | `dkan_alt_api` |
| Demo/sample datasets | `dkan_sample_content` |

## Admin / settings routes

| Path | Form / page | Permission |
| --- | --- | --- |
| `/admin/dkan` | DKAN admin landing (menu block) | `access administration pages` |
| `/admin/dkan/properties` | `DkanDataSettingsForm` (metastore properties) | `administer metastore settings` |
| `/admin/dkan/data-dictionary/settings` | `DataDictionarySettingsForm` | `administer data dictionary settings` |
| `/admin/dkan/data-dictionaries` | Data dictionary list | `create data content` |
| `/admin/dkan/datastore` | `DatastoreSettingsForm` | `administer site configuration` |
| `/admin/dkan/resources` | `ResourceSettingsForm` | `administer site configuration` |
| `/admin/dkan/datastore/status` | Import status dashboard | `dkan.harvest.dashboard` |
| `/admin/dkan/datastore/mysql_import` | `DatastoreMysqlImportSettingsForm` | `administer site configuration` |
| `/admin/dkan/js-frontend` | `DkanJsFrontendSettingsForm` | `administer site configuration` |

## API permissions to grant clients

Grant each API client only the verbs it needs (default roles `api_user`, `alternate_api_user` are
shipped as starting points):

- **Read** catalog/query/search: `access content` (held by anonymous on a default site → public catalog).
- **Datastore import/drop:** `datastore_api_import`, `datastore_api_drop`.
- **Harvest:** `harvest_api_index`, `harvest_api_info`, `harvest_api_register`, `harvest_api_run`
  (`harvest_api_run` also covers deregister/revert).
- **Metadata writes** (`POST/PUT/PATCH/DELETE /api/1/metastore/schemas/{schema_id}/items`) go through
  `MetastoreAccessManager`, which honours the legacy `post put delete datasets through the api`
  permission or, preferably, **standard node permissions on the `data` content type**
  (`create data content`, `edit any data content` / `edit own data content`, `delete any/own data content`).
  Prefer node permissions; the blanket legacy permission is deprecated.
- **Alt API** (`dkan_alt_api`): `get data through the alternate metastore api`,
  `query the alternate sql endpoint api`.

## Content model + key config

- Datasets are `node` bundle **`data`**; JSON metadata is in `field_json_metadata`, data-type in
  `field_data_type`. Publication uses the `content_moderation` workflow **`dkan_publishing`**
  (states draft / published / hidden / archived / orphaned; default state `published`). Reads over the
  API surface published items only.
- `dkan_metastore.settings`: `csv_headers_mode` (`resource_headers`|`machine_names`), `property_list`
  (which JSON properties become referenceable), `redirect_to_datasets`, `html_allowed_html`
  (HTMLPurifier allow-list for metadata), `resource_perspective_display`, `orphan.delete`.
- `dkan_datastore.settings`: `rows_limit` (500), `purge_file`, `purge_table`,
  `response_stream_max_age` (3600), `delete_local_resource`, `triggering_properties`.
- `dkan_common.settings`: `always_use_existing_local_perspective`.
- `dkan_datastore_mysql_import.settings`: `remove_empty_rows`.
- `dkan_js_frontend.config`: `datastore_query_api`, `js_folder`/`css_folder`, `minified`, `preprocess`.

## Drush

Provided across submodules: `dkan_common\Drush\Commands\CommonCommands`,
`dkan_datastore` (`DatastoreCommands`, `ReimportCommands`, `PurgeCommands`, `DegradedModeCommands`),
`dkan_harvest\Drush\Commands\HarvestCommands`.
