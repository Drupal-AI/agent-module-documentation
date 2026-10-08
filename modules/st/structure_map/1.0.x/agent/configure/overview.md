<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using Structure Map

No configuration is required — enable the module and use the admin pages. All routes require **`administer site configuration`**.

## View one bundle
1. Go to **Structure → Structure Map** (`/admin/structure/map`).
2. Select an **entity type** and **bundle** in the filter form.
3. The table (route `/admin/structure/map/{entity_type}/{bundle}`) shows:
   - basic entity info,
   - editorial permissions per role (who can create/edit/delete),
   - form and view display modes,
   - each field with its type/settings.

Options on the form let you additionally show relationship (reference) information and include hidden fields.

## Export many bundles
1. Go to **Structure Map → Export** (`/admin/structure/map/export`).
2. Choose the entity types/bundles to include and submit.
3. `ExportService` + `StructureMapExportFactory` build an **XLSX** (via `phpoffice/phpspreadsheet`) that you download — a spreadsheet snapshot of the selected architecture.

## Requirements
- Composer must have installed `phpoffice/phpspreadsheet ^3.5` (a dependency of the module) for the export to work.

## Notes
- The module is read-only: it creates no content and edits no configuration; it only reports on existing structure.
