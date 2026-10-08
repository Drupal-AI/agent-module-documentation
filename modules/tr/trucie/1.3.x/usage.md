<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imports content from an uploaded spreadsheet (xlsx/xls/ods/csv) into any entity type, driven by exportable *trucie importer* config entities with per-field processing rules.

---

Unlike Migrate (which needs a file already on the server) you select and upload the file directly on the importer form. Each importer config sets the target entity type/bundle, an import mode (create / create_update), a unique identity field, CSV parsing params, and a chain of field *processors*. Processors (in `TrucieImporterProcessor`) include `trim`, `explode`/`implode`, `intval`/`floatval`, `mb_strtolower`/`mb_strtoupper`, `ucfirst`, `preg_replace`, `strtotime`, `date`, and `entity_lookup` (resolve a referenced entity id by a field value). The header row supplies entity field machine names (e.g. `body__value`, `body__format`, `field_tags`); values flow through processors and are set on the entity via the standard entity API, so text fields honour their text-format filters. A `BatchImporterFactory` picks a CSV or Spreadsheet importer; four events (`PRE_PROCESS_RAW`, `PRE_PROCESS_DATA`, `PRE_SAVE`, `POST_SAVE`) allow custom manipulation, and a code API (`trucie.factory.importer`) supports custom import forms with dry-run, defaults and overrides.

Setup: create an importer at `/admin/structure/trucie-importer/add`, map columns to fields, add processors, then upload the file to run a batch import. All routes are gated by `administer trucie_importer`.

---
- Import nodes from a CSV file.
- Import taxonomy terms from an XLSX file.
- Create-or-update entities keyed on a unique field.
- Import any custom entity type, not just core content.
- Upload the source file directly on the form (no server placement).
- Map spreadsheet columns to entity field machine names.
- Split a delimited column into multiple values with the `explode` processor.
- Resolve referenced entities by label/field with `entity_lookup`.
- Normalise text with `trim`, `mb_strtolower`, `ucfirst`.
- Convert values with `intval`, `floatval`, `strtotime`, `date`.
- Apply regex transforms with `preg_replace`.
- Set a body text format via a `body__format` column.
- Export/import importer configuration between environments.
- Enable per-import logging.
- Hook into the import with PRE_PROCESS_RAW / PRE_PROCESS_DATA / PRE_SAVE / POST_SAVE events.
- Build a custom upload form using `trucie.factory.importer`.
- Run a dry-run import that processes but does not save.
- Provide default field values for empty cells.
- Force field overrides (e.g. status/uid) to prevent malicious values.
- Sync terms across environments by importing on `uuid`.
