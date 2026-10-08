<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-form export settings pane

All configuration lives in a fieldset that `coc_forms_auto_export_form_alter()` adds to Webform's
own **`webform_results_export`** form — i.e. **Structure → Webforms → *(form)* → Results →
Downloads**, section **"Automatic CSV Export"**. There is no site-wide settings form.

The form_alter reads the target webform id from the request URI
(`explode('/', getRequestUri())`, the segment after `manage`) and loads/writes the mutable config
object `coc_forms_auto_export.config.<webform_id>`.

## Fields (all in the `auto_csv_export` fieldset)

| Form key | Type | Purpose / notes |
|---|---|---|
| `enable_auto_export` | checkbox | Master switch. Everything below is `#states`-hidden until on. |
| `enable_sftp` | checkbox | Turn on SFTP delivery. |
| `sftp_host` / `sftp_username` / `sftp_password` / `sftp_destination` | textfield / textfield / **password** / textfield | SFTP connection. `sftp_destination` defaults to `.` (account root). Password field is only marked required when no password is stored yet; if left blank on re-save the existing stored password is kept. |
| `enable_email` | checkbox | Turn on email delivery. |
| `email` | email | Recipient for the CSV attachment. |
| `email_subject` | textfield | Module appends `" - <Form label>"` to it (in `hook_mail`). |
| `email_body` | text_format (full_html) | Supports tokens **`[Form_Name]`** and **`[Date_Range]`**, replaced at send time. |
| `records_from` | select | `previous_day` / `previous_week` / `previous_month` / `everything`. Drives which submissions are in range. |
| `cutoff_time` | select (hourly) | Only for `previous_day`; the 24h window ends at this time of the previous day. |
| `limit_to` | select | Which submission date to filter on: `date` (created) / `date_completed` / `date_changed`. |
| `frequency` | select | `hourly` / `daily` / `weekly` / `monthly` — how often cron re-runs the export. |
| `start_now` + `first_run_date` / `first_run_time_h` / `first_run_time_m` | checkbox + date/selects | Start immediately, or schedule the first run. |
| `never_end` + `no_runs_after_date` / `_time_h` / `_time_m` | checkbox + date/selects | Run forever, or auto-disable after a date/time. |
| `delimiter_single` | select | CSV delimiter for single values (default `,`). |
| `delimiter_multiple` | select | Delimiter within a multi-value cell (default `;`). |
| `columns` → `auto_export_excluded_columns` | custom `auto_export_excluded_columns` element | Sortable table-select of which columns to include (see below). |
| `update_auto_export_configs` | checkbox | Only shown once export is already enabled; must be ticked to persist edits to an already-enabled config (guards against accidental overwrite). |

An informational `export_details` markup block shows the next/last run, the computed selection
criteria and the included columns when auto export is already enabled.

## The column picker element

`auto_export_excluded_columns` (`Element\AutoExportExcludedColumns`, `@FormElement`, extends
`WebformExcludedBase`) renders a `webform_tableselect_sort` of the form's value-bearing elements
(`getElementsInitializedFlattenedAndHasValue('view')`, tokens replaced via `webform.token_manager`).
Despite the "excluded" name it stores the **included** columns: `validateWebformIncluded()` collapses
the table selection into the element value and errors if nothing is selected.

## Where settings are persisted

`_coc_forms_auto_export_update_auto_csv_export_settings()` (submit handler appended to the export
form's save action) writes on save, but only when the enable state changed or
`update_auto_export_configs` is ticked. It persists to **two** places:

1. **Config object** `coc_forms_auto_export.config.<webform_id>` — every scalar option above
   (`enable_*`, `sftp_*`, `email*`, `records_from`, `cutoff_time`, `limit_to`, `frequency`,
   `start_now`, `first_run_*`, `never_end`, `no_runs_after_*`, `delimiter_*`). It also enforces a
   dependency on `coc_forms_auto_export` so the config is removed with the module. The SFTP
   password is stored on this config object (when a new one is entered) alongside the other SFTP
   connection values.
2. **DB row** in `webform_auto_exports` (keyed by `name = webform_id`) — the scheduling/search state
   the cron reads: `schedule_config` JSON (`cron_schedule`, `frequency`, `start_now`, `first_run`,
   `next_run`, `never_end`, `no_runs_after`), `search_config` JSON (`records_from`, `start_date`,
   `end_date`, `end_time`, `included_columns`), plus `next_run` (unix ts), `enable_*`, `email`.
   Row is inserted on first enable, updated thereafter.

`next_run` is computed from `start_now`/first-run date+time and the frequency unit; if the first-run
time is in the past, it advances by whole frequency units until it is in the future.
`start_date`/`end_date` are either literal dates, `'all'` (for `everything`/start-now), or
`'initial'` (computed on the first cron run). `hook_uninstall` deletes every
`coc_forms_auto_export.config.*` object listed in the table.
