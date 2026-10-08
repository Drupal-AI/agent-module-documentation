<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trucie (trucie) — agent index

**Upload a CSV/XLSX/ODS/XLS file and batch create/update any entity type via configurable importers with per-field processors and events.**

- **Version:** 1.3.x (1.3.1)
- **Core:** ^9 || ^10 || ^11
- **Configure route:** `entity.trucie_importer.collection` → `/admin/structure/trucie-importer` (`_permission: administer trucie_importer`)
- **Permission:** `administer trucie_importer` (admin_permission of the config entity)
- **Config entity:** `trucie_importer` (target type/bundle, fid, mode, log, csv params, processors)
- **Services:** `trucie.factory.importer` (BatchImporterFactory → Csv/Spreadsheet importers), `TrucieImporterProcessor`
- **Processors:** trim, explode, implode, intval, floatval, mb_strtolower/upper, ucfirst, preg_replace, strtotime, date, entity_lookup
- **Events:** `TrucieEvents::PRE_PROCESS_RAW|PRE_PROCESS_DATA|PRE_SAVE|POST_SAVE` (RowEvent/EntityEvent)
- **Depends on** phpoffice/phpspreadsheet (composer)
- See [configure/importers.md](configure/importers.md)

**Security:** all routes gated by `administer trucie_importer`. Values are written through the entity API (text fields keep their format filters), so no raw-HTML sink. `preg_replace`/processor config is admin-only. No anonymous or public mutation endpoints.
