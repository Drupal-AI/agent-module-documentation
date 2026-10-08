<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LGPD/GDPR Auditor — scanner service, tables & workflow

Service **`advanced_filesystem_lgpd_gdpr.scanner`** = `Drupal\advanced_filesystem_lgpd_gdpr\LgpdFileScanner`
(`src/LgpdFileScanner.php`). Constructor args: `@database`, `@file_system`, `@file_url_generator`,
`@logger.channel.advanced_filesystem_lgpd_gdpr`.

## Storage (from `.install`)

- `advanced_filesystem_lgpd_findings` — `id` (serial PK), `fid`, `filename`, `filepath`,
  `finding_type`, `matched_pattern` (the regex, for audit), `matched_value` (redacted),
  `scanned_at`, `status` (`pending`|`reviewed`|`dismissed`), `notes`.
  Unique key `fid_type_value` = (`fid`, `finding_type`, `matched_value`) → duplicate matches are
  swallowed via `IntegrityConstraintViolationException`.
- `advanced_filesystem_lgpd_scanned` — `fid` (PK), `uri`, `filename`, `scanned_at`.

## Scan flow

- `countScannableFiles()` / `getScannableFids(int $limit=0)`: `file_managed` where `status=1`;
  fids additionally filtered to `SCANNABLE_MIME_PREFIXES` (`text/`, `application/json`,
  `application/xml`, `application/csv`, `application/ld+json`).
- `scanFile(int $fid, bool $rescan=FALSE): array` — the core unit:
  1. If `!$rescan` and `isAlreadyScanned($fid)`, returns `skipped`.
  2. Loads the `file_managed` row; if realpath is unreadable, logs a warning, marks scanned, returns.
  3. `readFileSafe()` reads up to `MAX_READ_BYTES` (4 MB), returns NULL for empty/binary content
     (>30% non-printable bytes in the first 512 B).
  4. On `$rescan`, deletes prior findings for the fid.
  5. Runs each `getEnabledPatterns()` regex with `preg_match_all`; inserts each `array_unique`
     match as a `redact()`ed row (`status = pending`).
  6. `markScanned()` upserts the scanned-tracking row.
- `redact($v)`: keeps `min(4, strlen)` leading chars, replaces the rest with `*`.

## Running a scan

- **Batch** — `LgpdAuditorScanForm` (route `.scan`). `submitForm()` chunks `getScannableFids($limit)`
  into `batch_set` operations calling static `LgpdFileScanner::processBatchChunk($chunk, $rescan,
  &$context)`; `batchFinished()` reports processed/skipped/findings counts.
- **Queue** — the same form's "Enqueue" submit (and `hook_cron`) call `enqueueAll($rescan,
  $chunkSize)` → `advanced_filesystem_lgpd_scan` queue → `LgpdScanWorker::processItem()` calls
  `scanFile()` per fid, catching per-file errors so one bad file never aborts the item.
  Drain manually: `drush queue:run advanced_filesystem_lgpd_scan`.

## Query & review API

- `getFindings(array $filters, int $limit, int $offset)` / `countFindings($filters)` — filters
  `type`, `status`, `filename_like` applied by `applyFilters()` (equality conditions; filename via
  `LIKE` with `escapeLike`). `limit=0` returns all (used by CSV export).
- `getSummary()` — `[finding_type => count]` for pending findings, `arsort`ed.
- `getFinding(int $id)`, `updateFindingStatus(int $id, string $status)` (validates the status enum),
  `updateFindingNotes(int $id, string $notes)`.

## Results UI

`LgpdAuditorResultsController` (route `.results`): renders a GET filter form, per-type summary
chips, a paginated `#type table` (50/page) and action links to `.finding_action` / `.finding_notes`.
`?export=csv` streams a CSV via `exportCsv()`. `findingAction(int $finding_id, string $action)`
validates `action ∈ {reviewed,dismissed,pending}`, calls `updateFindingStatus()`, and redirects
back to the results page. All displayed values are escaped (`htmlspecialchars` for `#markup`
fragments; scalar strings in table cells are auto-escaped by the table theme).
