# The `googlesheets` Webform handler

No site-wide config page. You add the handler to an individual webform at
`/admin/structure/webform/manage/<webform>/handlers` → *Add handler* → *Google Sheets*. Settings
are stored on the webform under `handlers.<id>.settings` (schema key
`webform.handler.googlesheets`).

## Prerequisites

- A Google Cloud project with the **Google Sheets API** enabled.
- A Google API Client module credential entity, EITHER:
  - an **OAuth 2.0 client** (`GoogleApiClient` entity, authenticated via its callback), or
  - a **Service Account** (`GoogleApiServiceClient` entity) — share the target sheet with the
    service account's email.
- The credential must include the `sheets` service and the
  `https://www.googleapis.com/auth/spreadsheets` scope. The handler form surfaces an *issues*
  checklist if the service/scope/authentication is missing.

## Settings keys (schema `webform.handler.googlesheets`)

| Key | Type | Default | Purpose |
|---|---|---|---|
| `spreadsheet_url` | string | `''` | Google Sheet URL (required). Parsed → `spreadsheet_id` + `spreadsheet_sheet_id`. |
| `spreadsheet_id` | string | `''` | Derived from the URL (not entered directly). |
| `spreadsheet_sheet_id` | int | `0` | The sheet gid; from `#gid=` (fragment wins) or `?gid=`. |
| `google_api_credential_type` | string | `google_api_client` | `google_api_client` (OAuth) or `google_api_service_client` (service account). |
| `google_api_client` | int | `0` | Selected `GoogleApiClient` entity id (OAuth path). |
| `google_api_service_client` | string | `''` | Selected `GoogleApiServiceClient` entity id (service-account path). |
| `multivalue_limit` | int | `0` | Max values exported per multi-value field (0–1000). |
| `multivalue_empty` | bool | `0` | Pad empty multi-value slots so columns stay aligned. |
| `comma_separate` | bool | `0` | Join multi-value answers into one comma-separated column. |
| `sort_data` | bool | `0` | Put submission metadata columns before submitted values. |
| `convert_date` | bool | `1` | Convert `created`/`completed`/`changed` timestamps to a date format. |
| `date_format` | string | `default` | Date format machine name, or `custom`. |
| `custom_date_format` | string | `''` | PHP date string used when `date_format == custom`. |
| `included_data` | (ignore) | all base fields | Column selector (`webform_excluded_columns`); keys here are EXCLUDED from output. |
| `use_queue` | bool | `FALSE` | Queue new submissions for cron delivery instead of sending immediately. |
| `queue_max_attempts` | int | `3` | Max queued delivery attempts (0 = unlimited). |

## URL parsing (`parseSpreadsheetUrl()`)

Accepts only `http(s)://docs.google.com/spreadsheets/d/<id>(/...)`. The sheet id (`gid`) is read
from the fragment first, then the query, and must be all digits. Invalid URLs fail validation
with "Please provide a valid Google Sheet URL."

## Delivery flow

- `postSave($submission, $update)` runs only for **new** submissions (`$update === FALSE`).
- If `use_queue`, `queueSubmission()` creates an item `{webform_submission_id, handler_id}` in
  queue `webform_googlesheets_submission`; otherwise `appendSubmission()` runs synchronously.
- `appendSubmission()`: `spreadsheets->get()` to read the sheet's column count, build the row,
  then `spreadsheets->batchUpdate()` with an `AppendCells` request (and an `AppendDimension`
  request first if the row has more columns than the sheet). Errors are caught in
  `handleErrors()`, logged, and dispatched as an error event.
- Queue worker (`WebformGoogleSheetsSubmission`): re-loads submission + handler, calls
  `appendSubmission(..., TRUE)` (rethrow on error), and on failure requeues with `attempts+1` and
  `not_before = now + 300s` until `queue_max_attempts` is reached, then gives up. Delivery is
  at-least-once — a timed-out but accepted append can create a duplicate row. Changes made after
  a successful delivery are NOT re-sent.

## Data shaping (`getData()` / `processValue()`)

- Drops unsupported properties (`metatag`); metadata vs. element order controlled by `sort_data`.
- `included_data` is applied as `array_diff_key` (keys present = excluded).
- Replaces tokens, then flattens: composites → `key_subfield[_i]` columns; multi-value → `key_i`
  columns (or comma-joined when `comma_separate`); likert handled specially. `multivalue_limit`
  caps counts; `multivalue_empty` pads with nulls.
- `text_format` element values export the `value` (HTML) part only.
- Managed-file values are exported as the file URI (`$file->getFileUri()`).
- Cell type in `prepareCell()`: bool→bool, int/double→number, string→string.

## Config example (partial webform handler entry)

```yaml
handlers:
  googlesheets:
    id: googlesheets
    handler_id: googlesheets
    status: true
    settings:
      spreadsheet_url: 'https://docs.google.com/spreadsheets/d/ABC123/edit#gid=0'
      google_api_credential_type: google_api_service_client
      google_api_service_client: my_service_account
      use_queue: true
      queue_max_attempts: 3
      convert_date: true
      date_format: default
```
