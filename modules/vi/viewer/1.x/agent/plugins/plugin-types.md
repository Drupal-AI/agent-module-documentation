<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types

Viewer defines five annotation-based plugin types, each a `DefaultPluginManager` subclass with its
own subdir under `src/Plugin/viewer/`, interface, base class, annotation, and `*_info` alter hook.
Add a plugin by dropping a class in your module's matching namespace; clear caches to discover it.

| Type | Service (manager) | Subdir | Annotation | Interface / base | Alter hook |
|------|-------------------|--------|------------|------------------|------------|
| Viewer (display) | `plugin.manager.viewer` | `Plugin/viewer/viewer` | `@Viewer` | `Plugin\ViewerInterface` / `ViewerBase` | `viewer_info` |
| ViewerType (file type) | `plugin.manager.viewer_type` | `Plugin/viewer/type` | `@ViewerType` | `ViewerTypeInterface` / `ViewerTypeBase` | `viewer_type_info` |
| ViewerSource (location) | `plugin.manager.viewer_source` | `Plugin/viewer/source` | `@ViewerSource` | `ViewerSourceInterface` / `ViewerSourceBase` | `viewer_source_info` |
| ViewerCell (cell converter) | `plugin.manager.viewer_cell` | `Plugin/viewer/cell` | `@ViewerCell` | `ViewerCellInterface` / `ViewerCellBase` | `viewer_cell_info` |
| ViewerProcessor (data shaper) | `plugin.manager.viewer_processor` | `Plugin/viewer/processor` | `@ViewerProcessor` | `ViewerProcessorInterface` / `ViewerProcessorBase` | `viewer_processor_info` |

## Viewer (display plugin) — `@Viewer`

Annotation keys (`src/Annotation/Viewer.php`): `id`, `name`, `empty_viewer_source` (bool — works
without a source), `viewer_types` (array of ViewerType ids it accepts, e.g. `{ "csv" }`), `processor`
(ViewerProcessor id), `filters` (bool — whether the viewer supports row filters). Extend `ViewerBase`
and implement `getRenderable()` (returns a render array with `#theme` + `#uuid` + attached JS
library); optionally override `settingsForm()`, `configurationForm()`, `settingsValues()`,
`configurationValues()`, `requirementsAreMet()`. `getResponse()` (used by the REST endpoint) returns
`getViewer()->getDataAsArray(TRUE)`. Bundled ids: `table`, `datatables`, `footable`, `spreadsheet`,
`accordion`, `tabs`, `vertical_tabs`, `pdfjs`, `fullcalendar`,
`chartjs_{bar,line,mixed,piedoughnut,scatterbubble}`,
`apexchart_{bar,line,mixed,piedoughnut,scatter,bubble,candlestick,treemap}`. See
`Plugin/viewer/viewer/Table.php` as the reference implementation (theme `viewer_table`, library
`viewer/viewer.table`).

## ViewerType (`@ViewerType`)

Keys: `id`, `name`, `default_viewer`, `extensions` (mime => extension map). Implement
`getContentAsArray(File, $settings)` (parse the file to a rows array), `getMetadata()`,
`propertiesForm()` / `submitPropertiesForm()` (per-type parse options), and `getExtensions()`.
Bundled: `csv`, `xlsx`, `pdf`.

## ViewerSource (`@ViewerSource`)

Keys: `id`, `name`, `provider`, `cron` (bool — eligible for scheduled import). Implement the form
lifecycle (`sourceForm`/`submitSourceForm`, `settingsForm`/`submitSettingsForm`,
`importForm`/`submitImportForm`) and `getFile($file, $settings, $type_plugin, $source_type)` which
returns a `file` entity for the processor. Base helpers in `ViewerSourceBase`: `getFileFromPath()`,
`getFileFromUrl()`, `getUploadPath()` (private stream if available, else public), `buildManualBatchItems()`,
`encryptString()`/`decryptString()` (AES-128-ECB keyed on `hash_salt`). Bundled: `upload`, `path`,
`url`, `ftp`, `sftp`.

## ViewerCell (`@ViewerCell`)

Per-column converter applied to each cell value during row building. Keys: `id`, `name`, `viewers`
(array of Viewer ids the converter is offered for). Implement `convert($value, $row)` — return a
string (may be HTML for the `img`/`link`/`peity` converters). Bundled: `as_is` (returns value
unchanged), `img`, `link`, `money`, `number`, `percentage`, `peity`. The default when a column has
no converter is `as_is`.

## ViewerProcessor (`@ViewerProcessor`)

Turns a source's parsed content into the `{headers, rows}` structure a display plugin serves.
Implement `getDataAsArray(ViewerInterface $viewer, $split_headers)`. Bundled: `processor_csv`
(`CsvProcessor.php` — header build, weight/hide/override column config, cell-converter application,
`minnur/array-query` filtering) and `processor_xlsx` (per-worksheet variant). A Viewer plugin names
its processor via the annotation `processor` key.
