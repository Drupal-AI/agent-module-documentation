<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel — data-transfer (import/export) plugins

Data-transfer plugins define file formats for exporting and importing translations. A plugin can be an
exporter, an importer, or both.

## Discovery
- Namespace: `Plugin\Babel\DataTransfer`. Attribute: `#[DataTransfer(id, label, fileExtensions[])]`
  (`src/Plugin/Babel/DataTransfer.php`).
- Manager: `DataTransferPluginManager` (`getExporters()`, `getImporters()`; parent `default_plugin_manager`,
  arg `@config.factory`). Alter hook: `hook_babel_data_transfer_info(&$definitions)`.
- Interfaces: `ExporterPluginInterface::createExportedFileContent($strings, $langcode, $extension): string`
  and `getExportGuidelines(): array`; `ImporterPluginInterface::getImportedTranslations($path, $langcode): array`
  plus `getImportErrors()` / `getImportWarnings()`. Base `DataTransferPluginBase`; importers reuse
  `ImporterPluginTrait` (error/warning collectors, `addImportError`/`addImportWarning`).

## Built-in plugin: `spreadsheet` (`DataTransfer\Spreadsheet`)
Both exporter and importer. Extensions: `xlsx`, `xls`, `ods`, `csv` (uses `phpoffice/phpspreadsheet`).

**Export** (`createExportedFileContent`): builds a sheet with a fixed header row —
`A` Source string (do not edit), `B` Translated string, `C` Context (do not edit), `D` Plural variant
(do not edit), `E` URL, `F` ID (do not edit = the 64-char source hash). Only **active** sources
(`status = 1`) are written; one row per plural variant. Columns `C`, `D`, `F` and the header are marked
protected (spreadsheet sheet protection); `A`, `B`, `E` editable. The file is written to a temp file and
returned as a string.

**Import** (`getImportedTranslations`): reads the sheet data-only. `validateSheet()` checks the header row
matches exactly (mismatch → import error). For each data row it reads the hash from column `F` and the
translation from `B`; `hashIsValid()` rejects rows whose hash is empty, not a `^[a-z0-9]{64}$` string, or
not present in `babel_source` (`hashExists`) — each becomes an import **warning** and the row is skipped.
Valid rows return `hash => [variant, …]`.

## Export flow (`Form\BabelExportForm`)
Route `babel.export`. Pick language + exporter + extension. `submitForm` fetches all strings for the
language, **filters out locked strings** (`isLocked()`), calls the exporter, then writes the file to
`babel.settings:data_transfer.destination` (default `public://babel`) with the sanitized prefix and a
download link. A message reports how many locked strings were excluded.

## Import flow (`Form\BabelImportForm`)
Route `babel.import`. Pick language + importer; upload a `managed_file` restricted to the plugin's
`fileExtensions`, stored under `data_transfer.destination`. `submitForm` loads the file, runs
`getImportedTranslations`, deletes the uploaded file, and — if there were no import *errors* — runs a batch
(`importTranslation`) that writes each translation to **every** backend instance of the hash via the owning
translation-type plugins, re-activating the source. Empty translations are ignored. Warnings and the
imported/deleted counts are reported on finish. Import does **not** overwrite locked translations only in the
sense that export excludes them; imported values are written through the translation-type plugins.

## Adding a format
Implement a plugin in `Plugin\Babel\DataTransfer` with the `#[DataTransfer]` attribute and one/both
interfaces; it automatically appears in the export/import forms for its declared extensions.
