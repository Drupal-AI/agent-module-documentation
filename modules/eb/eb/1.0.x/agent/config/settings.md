<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eb — install & configuration

## Install / enable
```bash
composer require drupal/eb
drush en eb -y            # base engine + YAML import
drush en eb_ui -y         # optional: browser YAML editor + AJAX API
```
Requires core `field`, `field_ui`, `user` (auto-enabled). PHP `^8.3`, Drupal `^11.0`. No external libraries for the base module. After enabling, set permissions at `/admin/people/permissions#module-eb` (see `../api/entities-and-routes.md` for the three tiers).

## Config object: `eb.settings`
Defined in `config/install/eb.settings.yml`, schema in `config/schema/eb.schema.yml` (`type: config_object`). Edit via the settings form (route `eb.settings`, path `/admin/config/development/eb/settings`, form `EbSettingsForm`, permission `administer entity builder`). Note the module `configure` link points to `eb.import` (the Import page), not the settings form.

Keys (with defaults):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `debug_mode` | bool | `false` | Enable extra debug behaviour. |
| `log_operations` | bool | `true` | Log every operation to the `eb` logger channel / watchdog (read by `OperationBase::shouldLog()`). |
| `enable_preview` | bool | `true` | Enable preview before execution. |
| `cardinality_unlimited` | int | `-1` | Value used to mean unlimited field cardinality. |
| `import_max_file_size` | int | `5` | Max import file size in MB (enforced in `EbImportForm` and API `MAX_CONTENT_SIZE` = 5 MB). |
| `import_history_retention_days` | int | `30` | Retention for import history. |
| `rollback_retention_days` | int | `30` | Retention for rollback records (used by `eb:rollback-purge`). |
| `default_items_per_page` | int | `50` | List pager size. |
| `batch_size` | int | `50` | Batch size for bulk operations. |
| `batch_threshold` | int | `50` | Operation count above which batch processing kicks in. |
| `max_recursion_depth` | int | `10` | Max recursion depth for data processing. |
| `export_signing_key` | string\|null | (unset) | Optional HMAC-SHA256 key; when set, `ExportSecurityService` prepends a `# SIGNATURE:` header to exports and verifies it on import (constant-time `hash_equals`). |
| `supported_entity_types` | sequence(string) | `node, media, taxonomy_term, paragraph, block_content, user` | Allowlist of entity types definitions may target. |

## Other schema in `eb.schema.yml`
- `eb.definition.*` — schema for the `eb_definition` config entity (label, description, `uid`, `project`, `dependencies_data`, and the `bundle_/field_/field_group_/display_field_/menu_definitions` sequences, plus `application_status`, `applied_date`). Rollback data is **not** exported with config — it lives in the `eb_rollback`/`eb_rollback_operation` DB tables.
- `eb.plugin.operation.*` and `eb.plugin.validator.*` — generic plugin config schema, plus one concrete `eb.plugin.operation.<id>` mapping per built-in operation (create_field, update_field, delete_field, hide_field, reorder_fields, configure_form_mode, configure_view_mode, create_bundle, update_bundle, delete_bundle, create_menu, create_menu_link).

## Uninstall
`eb_uninstall()` (in `eb.install`) deletes all `eb_log`, `eb_rollback_operation`, and `eb_rollback` entities.
