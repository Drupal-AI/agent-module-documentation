<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LGPD/GDPR File Auditor (advanced_filesystem_lgpd_gdpr) — agent index

Sub-module of **Advanced Filesystem**. Scans permanent managed files' text content for
personal-data regex patterns and records **redacted** findings in a review workflow.
Depends on core `file`, `system` and `advanced_filesystem`. Package `Advanced Filesystem`.
Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.27 (dir 1.0.x).

- **Settings, patterns, cron/queue, OCR fields, file-size cap** → [config/settings.md](config/settings.md)
- **Scanner service, batch/queue, findings tables, results & review workflow** → [api/scanner.md](api/scanner.md)

## What it actually is

- One service `advanced_filesystem_lgpd_gdpr.scanner` = `LgpdFileScanner` (`src/LgpdFileScanner.php`).
  Holds the fixed `PATTERNS` catalogue (cpf, cnpj, rg, br_phone, email, credit_card, ip_address,
  passport, iban) and all query/scan logic.
- No entities. Two custom DB tables from `.install`: `advanced_filesystem_lgpd_findings`
  (one row per unique fid+type+redacted value) and `advanced_filesystem_lgpd_scanned`.
- One QueueWorker plugin `advanced_filesystem_lgpd_scan` (`LgpdScanWorker`, `cron = {"time"=30}`).
- Hooks in `src/Hook/AdvancedFilesystemLgpdGdprHooks.php`: `hook_cron` (enqueue filler, gated by
  `cron_enabled` + `cron_interval`) and `hook_help`. Legacy wrappers in the `.module` file.
- Config object `advanced_filesystem_lgpd_gdpr.settings` (schema + install defaults present).

## Routes (all `_permission: 'administer site configuration'`)

- `advanced_filesystem_lgpd_gdpr.settings` — `LgpdAuditorSettingsForm` at `/admin/config/media/lgpd-auditor/settings`.
- `advanced_filesystem_lgpd_gdpr.scan` — `LgpdAuditorScanForm` (Batch scan / enqueue) at `.../scan`.
- `advanced_filesystem_lgpd_gdpr.results` — `LgpdAuditorResultsController::page` (table + CSV export) at `.../results`.
- `advanced_filesystem_lgpd_gdpr.finding_action` — `...::findingAction` at `.../findings/{finding_id}/{action}`
  (`action: reviewed|dismissed|pending`).
- `advanced_filesystem_lgpd_gdpr.finding_notes` — `LgpdFindingNotesForm` at `.../findings/{finding_id}/notes`.

## Mechanism (from source)

- `scanFile(fid, rescan)`: loads the `file_managed` row, resolves realpath, `readFileSafe()` reads up
  to `MAX_READ_BYTES` (4 MB) and skips binary (>30% non-printable in first 512 B), then runs each
  enabled pattern with `preg_match_all` and inserts `redact()`ed matches. Marks the file scanned.
- `getScannableFids()` filters `file_managed` by `status=1` and MIME in `SCANNABLE_MIME_PREFIXES`.
- Batch: `LgpdAuditorScanForm::submitForm` → static `LgpdFileScanner::processBatchChunk` / `batchFinished`.
- Queue: `enqueueAll()` chunks fids into `advanced_filesystem_lgpd_scan`; `LgpdScanWorker::processItem`
  calls `scanFile()` per fid.
- Results/CSV/status all read via `getFindings()/countFindings()/getSummary()` (query builder, filters
  parameterised, `escapeLike` on filename). `updateFindingStatus()/updateFindingNotes()` write back.

## Notes / caveats

- **Detection only** — the module records findings; it never edits, moves or deletes scanned files.
- Stored `matched_value` is redacted (first 4 chars + asterisks). The full matched string is not persisted.
- The settings form exposes OCR options (`ocr_*`) and `isOcrAvailable()` probes for a `tesseract` binary,
  but `scanFile()` in this version scans text content only — OCR/pdftotext are not invoked in the scan path.
