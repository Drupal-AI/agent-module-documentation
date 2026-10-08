<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities Import (entities_import) — agent index

Admin UI to **bulk-import content nodes and taxonomy terms from Excel/CSV files**. An admin defines
**`entities_import_type`** config entities (column→field mapping); uploading a spreadsheet against one
runs a **Batch** job that reads the file with **phpoffice/phpspreadsheet** and creates/updates one
entity per row. Version **2.0.0**. Core `>=8`. License GPL-2.0-or-later.

- **Import-type config entity, its schema/fields, forms, routes & permissions** →
  [config/import-type.md](config/import-type.md)
- **The upload → parse → map → batch-save run flow (and field/paragraph encoding)** →
  [import/run.md](import/run.md)

## What it actually is

- Requires the Composer library **`phpoffice/phpspreadsheet` `^1.16`** (`composer.json`). No declared
  Drupal module dependencies (`entities_import.info.yml`); it uses `node`, `taxonomy`, `file`, and
  optionally `paragraphs`/`language` at runtime only when those field types/features are present.
- One config entity type **`entities_import_type`** (`src/Entity/EntitiesImportType.php`,
  `@ConfigEntityType`, `admin_permission = "administer site configuration"`), managed under
  **Structure → Entities Import Type** (`/admin/structure/entities-import`).
- One dedicated module permission, **`Access Entities Import`** (`entities_import.permissions.yml`),
  which gates the file-upload/run route **`entities_import.file_upload`**
  (`/admin/entities-import/upload`, `entities_import.routing.yml`).
- Config schema in `config/schema/entities_import_type.schema.yml`. Menu/action links in
  `entities_import.links.menu.yml` / `.links.action.yml`. `hook_help()` in `entities_import.module`
  renders `README.txt`.

## Key classes (src/)

- `Form/EntitiesImportTypeForm` — add/edit form for an import type (entity type, bundle, unique-value
  fields, title field, file-path, sample file). Adds an **"Import {id}"** link to the run route.
- `Form/FileUploadForm` — the run form; on submit reads the query `type`, parses the upload, builds the
  Batch operations. `Form/EntitiesImportTypeDeleteForm` — delete confirm.
- `ReadExcel::readExcelData()` — loads the spreadsheet via `PhpOffice\PhpSpreadsheet\IOFactory::load`.
- `GenerateExcelData` — maps rows to entity field arrays (numbers, dates, references, file/image,
  paragraphs) and validates numeric fields.
- `DataStorage::save()` — the Batch callback that creates/updates the node/term (`finished` =
  `DataStorage::entities_import_batch_finished`). `FileDetails`, `FieldDetails`, `EntityDetails`,
  `EntityTranslationDetails`, `CommonUtilities`, `ImportUtilities` — helpers.
- `EntitiesImportTypeHtmlRouteProvider`, `EntitiesImportTypeListBuilder`, `EntitiesImportTypeViewBuilder`,
  `Entity/EntitiesImportTypeViewsData` — entity routing/list/view/Views plumbing.

## Notes

- Imported entities are always saved with **`uid = 1`** (`DataStorage::save()` sets `$node->uid`/term).
- File/image cells create managed `File` entities pointing at `public://{file_path}/{filename}`; the
  actual binaries must be placed on the server manually (see README step 5).
- No Drush commands; imports run only through the UI batch.
