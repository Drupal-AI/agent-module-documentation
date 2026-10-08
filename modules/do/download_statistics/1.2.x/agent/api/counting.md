<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How a download is counted (mechanism)

There is **no dedicated tracking endpoint or JS beacon**. Counting piggybacks on Drupal's own
private/managed file download routes.

## 1. Route swap — `Routing\FileDownloadAlterRouteSubscriber`

Service `download_statistics.route_subscriber` (tagged `event_subscriber`, ctor arg
`@config.factory`). `alterRoutes()`:

- Returns immediately unless config `download_statistics.settings:count_file_downloads` is TRUE.
- Otherwise sets `_controller` on the core routes **`system.private_file_download`** and
  **`system.files`** to `DownloadStatisticsFileController::download`.

So when counting is on, every private/managed file request runs through the module's controller.

## 2. Controller — `Controller\DownloadStatisticsFileController::download()`

Extends core `system\FileDownloadController`. Logic:

1. `$target = $request->query->get('file')`.
2. If `file_exists($scheme.'://'.$target)` (the *unprefixed* path exists) → `return parent::download()`
   — a normal, **uncounted** transfer. Normal file access is unchanged.
3. If `$target` does **not** start with `download-count/` → `parent::download()` (uncounted).
4. Otherwise strip the `download-count/` routing prefix, rebuild `$uri = $scheme.'://'.$target`,
   verify the scheme is valid and the file exists.
5. Call `moduleHandler()->invokeAll('file_download', [$uri])` — **this is the access check**
   (identical to core). Any module returning `-1` → `AccessDeniedHttpException`; empty result
   (no module granted access) → `AccessDeniedHttpException`.
6. On the first request only (`HTTP_RANGE` empty — range requests for the same file are not
   double-counted), load the `file` entity by URI (`getFileByUri()`, exact URI match) and call
   `statisticsStorage->recordDownload((int) $file->id(), (int) currentUser->id())`; log an error
   on failure.
7. Return the `BinaryFileResponse`.

The `download-count/` prefix is inserted by the display layer (formatters + `preprocess_file_link`),
never by the client picking it — and access is still enforced by `hook_file_download`.

## 3. Marking files for counting (two field formatters)

Files are "marked" during rendering, in a per-request static registry:

- **`counted_downloads_file`** — label "File with Download Statistics recorded"
  (`Plugin/Field/FieldFormatter/DownloadStatisticsFileFormatter`, extends core
  `GenericFileFormatter`, `field_types: ["file"]`). `viewElements()` records each viewed file id in
  `DownloadStatisticsFileFormatter::$countedFileIds`; `isMarkedForCounting($fid)` reports it.
  `isApplicable()`/registration require `count_file_downloads` TRUE.
- **`file_uri_download_count`** — label "File URI with Download Count"
  (`DownloadStatisticsFileUriFormatter`, extends core `FileUriFormatter`,
  `field_types: ["uri","file_uri"]`, only the `uri` field). `viewValue()` rewrites `private://` →
  `private://download-count/` in the emitted URI.

`Hook\DownloadStatisticsHooks::preprocessFileLink()` (hook_preprocess_file_link): for a file whose
id `isMarkedForCounting()`, it rewrites the link URL to the `private://download-count/…` form via
`fileUrlGenerator->generateAbsoluteString()`, so the rendered link routes through the counting
controller. `form_views_ui_config_item_form_alter` hides both formatter options in the Views UI
when counting is off.

## 4. Storage — `DownloadStatisticsDatabaseStorage`

Service `download_statistics.storage.file` (tagged `backend_overridable`; interface alias
`DownloadStatisticsStorageInterface`; ctor `@database, @state, @request_stack, @current_user`). Key
methods (all use the DB API — parameterized, `$fid`/`$uid` cast to int; `$order`/`$dbfield`
validated against a `['totalcount','daycount','timestamp']` allow-list):

- `recordDownload(int $fid, int $uid = 0): bool` — `MERGE` on key `fid`, inserting counts=1 or
  `daycount = daycount + 1`, `totalcount = totalcount + 1`, plus `timestamp` and `uid`.
- `fetchDownload($id)` / `fetchDownloads($ids)` — return `DownloadStatisticsCountResult` value
  objects (getTotalCount/getDayCount/getTimestamp/getUserId).
- `fetchAll($order, $limit)` — ordered file-id list (used by the block).
- `deleteDownloads($fid)` / `deleteAllDownloads()` — used by `file_predelete` and the settings form.
- `resetDayCount()` — zeroes `daycount` once per 24h (state `download_statistics.day_timestamp`).
- `maxTotalCount()` — `MAX(totalcount)` (drives the ranking scale).
- `getFilenameList($dbfield, $dbrows)` — joined file/user list, tagged `file_access`.

Procedural helper `download_statistics_get(int $id): array|false` (in `.module`) wraps
`fetchDownload()` → `['totalcount','daycount','timestamp','uid']`.

## 5. DB table — `hook_schema()` in `download_statistics.install`

Table **`download_statistics`**, primary key `fid`:

| Field | Type | Meaning |
|---|---|---|
| `fid` | int unsigned (PK) | `file_managed.fid` |
| `totalcount` | int unsigned big, default 1 | all-time downloads |
| `daycount` | int unsigned medium, default 1 | downloads "today" |
| `timestamp` | int unsigned, default 0 | most recent download time |
| `uid` | int unsigned | UID of the most recent downloader |

`hook_uninstall()` deletes state keys `download_statistics.download_counter_scale` and
`download_statistics.day_timestamp`. `hook_file_predelete` deletes that file's row.

## 6. Cron & search ranking — `Hook\DownloadStatisticsHooks`

- `cron()` (when counting on): `resetDayCount()`, then stores
  `state:download_statistics.download_counter_scale = 1.0 / max(1.0, maxTotalCount())`.
- `ranking()` (hook_ranking, when counting on): returns a `downloads` ranking joining
  `download_statistics` on `i.sid = fid`, scoring by `totalcount` scaled by that state value
  (parameterized `:download_statistics_scale`) — boosts popular downloads in core search.
