<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO — configuration, permissions, storage

The module ships **no `config/schema/` or `config/install/`** files; config objects are created at
runtime by the settings forms and by `hook_install`. Source: `src/Form/EntityExportSettingsForm.php`,
`src/Form/EntityImportSettingsForm.php`, `src/Form/FormSettings/*FieldConfigForm.php`,
`entity_io.install`, `entity_io.permissions.yml`, `entity_io.routing.yml`.

## Config objects (all `entity_io.*`)

- **`entity_io.export_settings`** — read by the exporter/controllers: `storage_scheme`
  (`public`|`private`, default `public`), `directory` (default `entity_io_exports`),
  `export_format` (`json`|`gz`|`br`), `internal_optimize_json` (bool; enables JSON compression).
  Edited at `entity_io.export_settings` (`/admin/config/entity-io/settings/export`).
- **`entity_io.import_settings`** — read by `EntityImporter`: `import_user` (uid to impersonate),
  `import_create_new_revision` (bool), `ignore_import_older` (bool; enable `validateLastChanged`),
  `user_entity` (bool; controls recursive user import). Edited at `entity_io.import_settings`
  (`/admin/config/entity-io/settings/import`).
- **`entity_io.settings`** — `api_user`, `api_pass` (Basic-Auth credentials checked by
  `JsonApiController::receiveJson` with `hash_equals`).
- **`entity_io.export_storage`** — written by `hook_install` (`storage_scheme`, `directory`,
  `import_create_new_revision`).
- **Per-bundle field-selection configs** — one object per supported entity type, each keyed by
  bundle → `{fields, base_fields, depth}`: `entity_io.content_type_field_settings` (node),
  `entity_io.user_field_settings`, `entity_io.taxonomy_term_field_settings`,
  `entity_io.block_content_field_settings`, `entity_io.paragraph_field_settings`,
  `entity_io.media_field_settings`, `entity_io.comment_field_settings`,
  `entity_io.file_field_settings`. `EntityIoExport::getSelectedFields()` / `getDepth()` read these;
  an empty config means "export all fields". `hook_install` seeds them via
  `Helper\EntityIoBaseFieldsInstaller::checkAllBaseFields()`.

## Field-selection forms (`Form\FormSettings\*`)

All at `_permission: administer site configuration`, paths `/admin/config/entity-io/<x>/fields`,
menu group *Entity IO → Entity Fields*:

| Route | Form class | Config written |
|---|---|---|
| `entity_io.node_fields` (the module `configure` route) | `ContentTypeFieldConfigForm` | `content_type_field_settings` |
| `entity_io.paragraphs_fields` | `ParagraphsFieldConfigForm` | `paragraph_field_settings` |
| `entity_io.taxonomy_fields` | `TaxonomyTermFieldConfigForm` | `taxonomy_term_field_settings` |
| `entity_io.user_fields` | `UserFieldConfigForm` | `user_field_settings` |
| `entity_io.file_fields` | `FileFieldConfigForm` | `file_field_settings` |
| `entity_io.media_fields` | `MediaFieldConfigForm` | `media_field_settings` |
| `entity_io.comment_fields` | `CommentFieldConfigForm` | `comment_field_settings` |
| `entity_io.block_fields` | `BlockContentFieldConfigForm` | `block_content_field_settings` |

## Permissions (`entity_io.permissions.yml`)

`entityio import json`, `export node json`, `export taxonomy json`, `export user json`,
`export block json`, `export media json`, `export batch json`. The comment export form route
requires `administer export comment json`, which is **not declared here**. Field-config forms,
per-entity `*/export/json` controller routes, the private download route and the log viewer use core
`administer site configuration`. (Route→permission tables: [../api/export.md](../api/export.md).)

## Storage & tables

Exports are written under `<storage_scheme>://<directory>/<entity_type>/`. With the `private`
scheme, files are served through `entity_io.private_file_download`
(`FileDownloadController::download`, `administer site configuration`). DB tables from
`entity_io.install`: `entity_io_storage` (UUID map) and `entity_io_log` (operation log).
