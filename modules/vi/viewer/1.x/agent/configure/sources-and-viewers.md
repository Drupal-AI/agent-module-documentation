<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure sources and viewers

Viewer models data in two content entities. A **`viewer_source`** answers "which file, from where,
parsed how"; a **`viewer`** answers "which display plugin, which columns, which filters, bound to
which source". You always create a source first, then one or more viewers on it.

## Sources — `/admin/structure/viewer-source`

- List/collection route `entity.viewer_source.collection` (perm `administer viewer source`). The
  "New Source" action (`entity.viewer_source.new`, perm `add viewer source`) opens a modal
  (`Form/Source/NewForm`) that first picks a **file type** (ViewerType: `csv`, `xlsx`, `pdf`) and a
  **source** (ViewerSource: `upload`, `path`, `url`, `ftp`, `sftp`), then routes to
  `viewer_source.new_source` (`/admin/structure/viewer-source/source/{viewer_type}/{viewer_source}`,
  `Form/Source/SourceForm`).
- Source plugin classes live in `src/Plugin/viewer/source/`:
  - `upload` (`Upload.php`) — a `managed_file` element; `#upload_validators` uses
    `file_validate_extensions` from the ViewerType's allowed extensions. Stored as a permanent file.
  - `path` (`FilePath.php`) — an **absolute server path** textfield; supports `[date:*]` tokens.
    `getFile()` calls `getFileFromPath()` in `Plugin/ViewerSourceBase.php` which guesses the mime
    type from the name and only proceeds if it matches the ViewerType's extension list.
  - `url` (`FileURL.php`, extends `FilePath`) — a **remote URL** textfield; `getFileFromUrl()`
    HEAD-checks `Content-Type` against the allowed list, then `file()`-downloads it.
  - `ftp` (`Ftp.php`) / `sftp` (`SFtp.php`) — host/port/credentials; downloaded via the
    `viewer.ftp_sftp` service (`Services/FtpSftp.php`, League Flysystem FTP/SFTP adapters). SFTP
    supports password or private key.
- ViewerType plugins (`src/Plugin/viewer/type/`) define parse behaviour and allowed extensions:
  - `csv` (`Csv.php`) — `delimiter` / `enclosure` / `escape` properties (defaults `,` `"` `\`);
    extensions `text/csv`, `text/plain`. `processor_csv` builds the row/header arrays.
  - `xlsx` (`Xlsx.php`) — extensions `…spreadsheetml.sheet` (xlsx), `application/vnd.ms-excel` (xls);
    parses every worksheet via `phpoffice/phpspreadsheet` (`IOFactory`). `processor_xlsx`.
  - `pdf` (`Pdf.php`) — extension `application/pdf`; `getContentAsArray()` returns `[]` (rendered by
    the `pdfjs` viewer, not tabulated).
- Per-source operations (entity routes, all under `/admin/structure/viewer-source/{viewer_source}/…`):
  `settings` (`Form/Source/SettingsForm`), `schedule` (form `viewer_source.schedule`), `notifications`
  (form `viewer_source.notifications`), `enable`/`disable` (`ViewerSourceController::setActive/Inactive`),
  `download` (`ViewerSourceController::download`, perm `add viewer source`), `import`
  (`Form/Source/ImportForm`, perm `add viewer source`), `delete`, `edit`. Bulk re-import of all
  sources: `entity.viewer_source.bulk_import` (`/admin/structure/viewer-source/bulk-import`,
  `Form/Source/BulkImportForm`, perm `bulk import viewer source`).
- Imports run through a Batch (`Services/Batch.php`, `viewer.batch`) and, when a source has an import
  frequency, through the Queue on cron (see drush/commands.md).

## Source data model (base fields on `viewer_source`)

`name`, `type_plugin`, `source_plugin`, `import_frequency` (`viewer_import_frequencies()`), `settings`
(serialized parse settings), `metadata` (serialized column headers), `file_id` (ref to the stored
`file`), `status` (active/inactive), `last_import`, `next_import`. Parsed contents are cached in the
`data` cache bin under cid `viewer_source:{id}` and invalidated on save/delete
(`Traits/ViewerSourceTrait.php::getContentAsArray()`).

## Viewers — `/admin/structure/viewers`

- Collection `entity.viewer.collection` (perm `administer viewer`; this is also the module's
  `configure` route). "New Viewer" (`entity.viewer.new`, perm `add viewer`, `Form/Viewer/NewForm`)
  picks a **display plugin** (Viewer plugin id) and a **source**.
- Per-viewer operations under `/admin/structure/viewers/{viewer}/…`: `configuration`
  (`ViewerController::setConfigurationTitle` + form `viewer.configuration`) — the per-column table
  (override header, hide, empty, **cell converter**, weight/order); `settings` (form
  `viewer.settings`) — plugin display options (e.g. Table's `items_per_load`, `show_all`,
  `load_more_label`, `add_headers`, last-import display); `filters` (form `viewer.filters`) — row
  filters evaluated by `minnur/array-query`; `endpoint` (form `viewer.endpoint`); `iframe_preview` /
  `iframe_preview_src` (live preview, perm `add viewer`); `enable`/`disable`; `edit`; `delete`.
- Column configuration is per Viewer plugin. `Plugin/viewer/viewer/Table.php::configurationForm()`
  is the canonical example; the chosen `cell_plugin` per column (default `as_is`) is applied in
  `processor_csv`/`processor_xlsx` `buildRows()` via `ViewerCell::convert()`.

## Viewer data model (base fields on `viewer`)

`name`, `viewer_plugin` (the display plugin id), `viewer_source` (entity ref), `filters`
(serialized), `settings` (serialized), `configuration` (serialized column config), `status`.
`getDataAsArray()` delegates to the display plugin's processor, which reads the source's cached
content, applies column config + cell converters + filters, and returns `{headers, rows}`.

## Scheduled imports and notifications

- A source with a non-zero `import_frequency` gets a `next_import` timestamp; `viewer.cron`
  (`Services/Cron.php`, called from `hook_cron`) enqueues due sources into the
  `ViewerSourcesQueueProcessor` queue worker, which re-runs the import.
- The `notifications` form stores a Slack webhook URL and/or email addresses. On import
  success/failure `ViewerEventsSubscriber` fires and `viewer.notifications`
  (`Services/Notifications.php`) posts to Slack (`@http_client`) or sends mail (`hook_mail` key
  `notification`). Event constants: `Event/ViewerEventType.php` (`IMPORT_SUCCESS`, `IMPORT_FAILED`).
