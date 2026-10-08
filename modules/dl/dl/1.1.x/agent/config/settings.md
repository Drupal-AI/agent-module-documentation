<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, file-field configuration, install/uninstall

## Enable

`ddev drush en dl -y`. Declared dependencies (`dl.info.yml`): node, file, user, views, taxonomy.
`hook_install` (`dl.install`) just prints a status message; the entity and its configurable fields
come from `config/install/` (field storage/instance YAML for `field_file`, `field_description`,
`field_version`, `field_tags`, plus form/view displays and view/form modes). There is **no**
composer.json, no Drush commands, no config schema directory (the `dl.settings` object ships
without a `config/schema/` definition).

## `dl.settings` config object (`src/Form/SettingsForm.php`)

`ConfigFormBase`, form id `dl_settings_form`, editable name `dl.settings`. Reachable at
`/admin/config/content/document-library` (`dl.admin_settings`) and `/…/settings` (`dl.settings`),
perm `administer document library`. Keys and defaults:
- `items_per_page` (int, default 20, min 5 / max 100) — recent-documents range on the library page.
- `enable_versioning` (bool, default TRUE) — read by `viewDocument` (`#enable_versioning`).
- `enable_downloads_tracking` (bool, default TRUE).
- `enable_favorites` (bool, default TRUE) — gates favorite UI on library/view pages.
- `enable_comments` (bool, default FALSE).
- `theme` (`light`|`dark`|`auto`, default `light`), `show_thumbnails` (bool, default TRUE).

The form's own help text notes that upload size/extension settings are **not** here — they live on
the File field (see below). `configure` in `dl.info.yml` points at `dl.admin_settings`.

## File field configuration (Field UI)

The document's file constraints are the standard core File field `field_file`, edited at
**Structure → Documents → Manage fields → Document File** (Field-UI base route
`entity.document.settings` → `/admin/structure/document/settings`, perm
`administer document library`). Defaults from `config/install` / `dl_update_9005`:
- `file_extensions`: `txt pdf doc docx xls xlsx ppt pptx odt ods odp rtf zip rar 7z tar gz`
- `max_filesize`: `50 MB`
- `uri_scheme`: `public` (switchable to `private` etc. — `dl.module`'s `hook_form_alter` unlocks
  the URI-scheme radios on the field-storage edit form and adds a custom submit
  `dl_field_storage_uri_scheme_submit`).
- `file_directory`: `documents/[date:custom:Y]-[date:custom:m]`. `dl.module` also relaxes the
  default token validation and (with the token module) exposes custom
  `[entity:document:folder-path|folder-name|folder-slug|folder-id]` tokens defined in
  `dl.tokens.inc` for the directory pattern.

Note: because `uri_scheme` defaults to `public`, uploaded files are stored under the public files
directory and are directly reachable by their file URL like any public Drupal file; switch the
scheme to `private` if downloads must be permission-mediated at the filesystem level.

## Uninstall (`dl_uninstall`)

Deletes all `document` entities (triggering `postDelete` file cleanup), deletes orphaned version
files listed in `dl_versions`, recursively removes `public|private|oci://documents` directories,
deletes the `dl.settings` and `dl.field_config` config objects, and removes the four field
storages/instances plus the default form/view displays. Custom tables are dropped by core when the
module's `hook_schema` is torn down.

## Update path

`hook_update_N` in `dl.install` migrated an earlier design: `9001` added folders, `9002` removed a
`category_id`/vocabulary model (categories replaced by folders), `9003` added folder slugs, `9004`
moved storage to the entity API, `9005` converted base file/description/version/tags columns to
configurable fields (with data migration from the legacy `dl_documents` table), `9006` recreates
`field_file` if it was deleted.
