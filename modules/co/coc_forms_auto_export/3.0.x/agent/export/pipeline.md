<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export pipeline (cron → exporter → SFTP / email)

The export is driven **entirely by `coc_forms_auto_export_cron()`** (`hook_cron`). There is no
HTTP/route path. A working Drupal cron, running often enough for the configured frequency, is
required.

## `hook_cron` flow (`.module`)

1. Select rows from `webform_auto_exports` where `enable_auto_export = 1` **and** `next_run <= now`.
2. Per row:
   - **Auto-disable check.** If `never_end` is false and `now > no_runs_after`, set
     `enable_auto_export = 0` in both the DB row and the config object, log it, and `return`
     (note: `return`, not `continue` — it stops the whole cron pass, not just this form).
   - **Build export options** from `webform_submission.exporter`'s defaults, then override:
     `exporter = 'coc_delimited'`, `delimiter`/`multiple_delimiter` from config, and crucially
     **`access_check = FALSE`** (cron has no user). Date range comes from `search_config`:
     literal dates → `range_type = 'date'`; `'initial'` → computed via
     `coc_forms_auto_export_get_new_date_range(..., before=TRUE)` using `limit_to` as range type;
     `'all'` → `range_type = 'all'`. `excluded_columns` is set to the stored *included* columns.
   - **Query submissions** with `->accessCheck(FALSE)`; if zero in range, log a warning and skip
     delivery (but still reschedule).
   - **Generate** the CSV via `$submission_exporter->generate()`; the file path comes from
     `getExportFilePath()` (Webform's exporter temp location — not a public URL).
   - **SFTP delivery** (if `enable_sftp`): `SFTPController::sendFile($sftp, $file_path,
     "<webform_id>-<now>.csv")` with host/user/pass/destination from config. Success/failure logged
     to channel `webform_auto_exports`.
   - **Email delivery** (if `enable_email`): builds a `stdClass` attachment (uri, filename
     `<webform_id>.csv`, mime `text/csv`, form label, date-range string, subject, body) and calls
     `plugin.manager.mail->mail('coc_forms_auto_export', 'basic', $to, <default langcode>, $files)`.
   - **Reschedule.** Advance `next_run` by whole frequency units until it is in the future; advance
     `search_config` start/end dates by one frequency period
     (`coc_forms_auto_export_get_new_date_range`, `before=FALSE`); write `last_run = now`.

## The `coc_delimited` exporter plugin

`Plugin/WebformExporter/COCDelimitedWebformExporter` extends core Webform's
`DelimitedWebformExporter`. It overrides:
- `getElementsInOrder()` — if `excluded_columns` (really the *included* set) is present, emit only
  those elements, in that order; otherwise all value-bearing elements (with tokens replaced).
- `writeHeader()` / `writeSubmission()` — build header/record rows from those elements via the
  Webform element manager's `buildExportHeader` / `buildExportRecord`, `fputcsv` to the file handle.

## `hook_mail`

`coc_forms_auto_export_mail()` handles key `'basic'`: sets `Content-Type: text/html`, subject =
`"<email_subject> - <Form label>"`, and body = the configured `email_body` with `[Form_Name]` and
`[Date_Range]` substituted (`str_replace`) and wrapped in `Markup::create`. The CSV rides as the
attachment assembled in `hook_cron` (`$params['files']`).

## SFTP helper

`SFTPController::sendFile($sftp_details, $source_path, $file_name, $mode = SFTP::SOURCE_LOCAL_FILE)`:
`new SFTP($host)` → `login($username, $password)` → `createDirectory()` (mkdir/chdir each path
segment of the destination) → `put(destination/file_name, source_path, mode)`. All inputs are the
admin's per-form config. Login failure calls `exit('Login Failed')`.

## Date-range helpers

- `coc_forms_auto_export_get_date_range($form_state)` — initial start/end at save time
  (`'all'`/`'initial'` or a concrete previous day/week/month/year window).
- `coc_forms_auto_export_get_new_date_range(...)` — shifts a window forward by one period (or, with
  `before=TRUE`, computes the first concrete previous-period window).
- `coc_forms_auto_export_get_schedule()` / `_get_frequency_unit()` — map frequency to a cron-style
  string and to a `strtotime` unit (`hour`/`day`/`week`/`month`/`year`). (`get_schedule` also
  handles a `yearly` case although the form's frequency select only offers hourly–monthly.)
