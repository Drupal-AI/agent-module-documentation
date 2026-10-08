<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Structure Map documents a Drupal site's information architecture: for a chosen entity type and bundle it lays out the fields, form/view display modes, widgets and formatters, and the roles that can create/edit/delete that bundle, and can export the same across many bundles to a spreadsheet.

---

The module adds an admin section under **Structure → Structure Map** (`/admin/structure/map`). The overview form (`StructureMapFilterForm`) lets you pick an entity type and bundle and renders a structure table (`StructureMapController::entityBundle`, route `/admin/structure/map/{entity_type}/{bundle}`) showing basic entity info, editorial permissions per role, display modes and per-field settings. A second filter form at `/admin/structure/map/export` (`StructureMapFilterFormExport`) drives `ExportService` + `StructureMapExportFactory` to build an XLSX file via `phpoffice/phpspreadsheet` covering multiple entities/bundles at once — useful for capturing or handing off a complex site's architecture. The `EntityTypeInfo` service gathers the field/display/widget metadata the tables are built from.

Security/operational notes: every route is gated by the strong **`administer site configuration`** permission — the overview, the per-bundle controller, and the export are all admin-only, so there is no anonymous or mutating surface (the module is read-only reporting; it creates no content and changes no config). The `{entity_type}/{bundle}` parameters are `\w+`-constrained and resolved through the entity-type manager, so they cannot address anything the admin could not already view. The module requires `phpoffice/phpspreadsheet ^3.5` (installed via Composer) for the XLSX export. Setup is just enabling the module — the README states no configuration is required; then visit `/admin/structure/map`.

---
- View the field/display/permission structure of any entity bundle
- Browse to `/admin/structure/map` and pick an entity type + bundle
- See which roles can create/edit/delete a given content type
- List all fields on a bundle with their types and settings
- Inspect a bundle's form display modes and widgets
- Inspect a bundle's view display modes and formatters
- Optionally show relationship (entity-reference) information
- Optionally include hidden fields in the map
- Export multiple entities/bundles to an XLSX spreadsheet
- Use `/admin/structure/map/export` to select what to export
- Capture a snapshot of site architecture for documentation
- Hand off a site's structure to another team as a spreadsheet
- Audit editorial permissions across content types
- Understand an inherited/complex site before making changes
- Compare bundles' field configurations side by side
- Produce architecture reports without reading config YAML by hand
