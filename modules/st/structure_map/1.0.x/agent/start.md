<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Structure Map (structure_map) — agent index
**Read-only admin reporting that maps entity/bundle architecture (fields, displays, widgets, editorial permissions) and exports it to XLSX.**

- **Version:** 1.0.x (dev checkout `dev-1.0.x`)
- **Core:** `^9 || ^10 || ^11`
- **Depends on:** core `config`, `field`, `system`, `field_ui`, `menu_ui`, `user`; Composer: `phpoffice/phpspreadsheet ^3.5` (XLSX export).
- **Routes (all `_permission: administer site configuration`):**
  - `structure_map.overview` → `/admin/structure/map` (`StructureMapFilterForm`)
  - `structure_map.export` → `/admin/structure/map/export` (`StructureMapFilterFormExport`, XLSX via `ExportService`)
  - `structure_map.entity_bundle` → `/admin/structure/map/{entity_type}/{bundle}` (`StructureMapController::entityBundle`; params `\w+`)
- **Services:** `structure_map.entity_type_info` (metadata gathering), `structure_map.export`, `structure_map.export_factory`.
- **Config:** none required (per README).

**Security:** Every route is gated by the strong `administer site configuration` permission; no anonymous, mutating, or CSRF-relevant endpoints — the module is read-only reporting. `{entity_type}/{bundle}` are `\w+`-constrained and resolved via the entity-type manager. No security findings.

See [configure/overview.md](configure/overview.md).
