<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migration Hbk Auto endpoints

| Route | Path | Access | Controller action |
|---|---|---|---|
| import_from_d7 | `/admin/migration-hbk-auto/import-from-d7` | `access content` | renders Vue app |
| manage_config | `/admin/migration-hbk-auto/manage-config` | `access content` | `ManageConfigController::loadConfig` |
| generate_fields | `/admin/migration-hbk-auto/generate-fields` | `access content` | `ManageConfigController::generateFields` |
| import_files | `/admin/migration-hbk-auto/import-files` | `access content` | `ManageConfigController::importFiles` |
| import_terms | `/admin/migration-hbk-auto/import-terms` | `access content` | `ManageConfigController::CheckTermsExist` |
| migration_settings | `/admin/config/system/migration-settings` | `administer site configuration` | settings form |
| get_migration_settings | `/admin/migration-hbk-auto/get-migration-settings` | `administer site configuration` | returns settings JSON |

Action endpoints read a JSON request body (`Json::decode($request->getContent())`): `generateFields` needs `entity_type`, `bundle`, `bundle_key`, `fields`; `importFiles` needs `files`, `base_url`; `loadConfig` needs `config_id`, `datas`; `CheckTermsExist` needs `terms`, `vocabularies`.

Config `migration_hbk_auto.settings` holds `source_site_url` (the D7 source). Note the four action routes use `access content` — restrict them (e.g. via a route alter or permission change) before exposing the site.
