<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alt text import CSV (alt_text_import_csv) — agent index

Bulk-updates image **alt text** on content entities from an uploaded CSV whose columns are
**page URL, image URL, alt text**. Admin utility, no entities/fields/plugins of its own.
Version **1.0.0-beta5**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.

- **Upload form, batch pipeline, URL→entity matching, results page** →
  [import/csv-import.md](import/csv-import.md)
- **Settings config object, schema, email reports** → [config/settings.md](config/settings.md)

## Dependencies

Core `media`, `path`; contrib `entity_usage` (finds which entities reference a file) and
`multivalue_form_element` (the settings form's repeatable email field). No `composer.json` in the
package — deps are declared only in `alt_text_import_csv.info.yml`.

## What it provides (all from source)

- **Routes** (`alt_text_import_csv.routing.yml`):
  - `alt_text_import_csv.import` — `/admin/config/media/alt-text-csv-import`, form
    `Form\AltTextImportForm`, perm `update image alt texts via csv files`.
  - `alt_text_import_csv.import.results` — `…/results/{file}`, `Controller\ImportResultsController`,
    same perm; `{file}` upcast to a `file` entity, failures read from the current user's private
    tempstore.
  - `alt_text_import_csv.settings` — `/admin/config/media/alt_text_import_csv/settings`,
    form `Form\AdminSettingsForm`, perm `administer alt_text_import_csv`.
- **Permissions** (`alt_text_import_csv.permissions.yml`, both `restrict access: true`):
  `update image alt texts via csv files`, `administer alt_text_import_csv`.
- **Service** `alt_text_import_csv.alt_text_importer` = `AltTextImporter` (args
  `entity_type.manager`, `file.repository`, `path_alias.manager`).
- **Batch class** `AltTextImportBatch` (static `processRow`/`finish` callbacks; not a service —
  see the `@todo` in the class).
- **Value object** `HostEntityItem` (readonly `hostEntity` + `fieldNames`).
- **Hooks** (`alt_text_import_csv.module`): `hook_help`, `hook_mail` (mail key `report`).
- **Config**: object `alt_text_import_csv.settings` (schema + install defaults), keys `mails`,
  `no_page_url_match_update_all`, `media_only`.

## Operating notes

- Not a content type / field / formatter / plugin type — purely an import utility.
- The importer writes only the `alt` property on image reference fields, then re-saves each matching
  host entity (which updates the entity's changed time and may create a revision / fire save hooks).
- Header rows are auto-skipped; rows with an empty image URL or alt text are silently skipped; rows
  with an invalid page/image URL or an unresolvable file are reported as failures.
