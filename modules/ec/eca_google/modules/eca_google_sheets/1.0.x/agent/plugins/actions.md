<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Sheets ECA actions

Seven `ConfigurableActionBase` plugins in `src/Plugin/Action/`. Each declares `#[Action(id, label,
category: 'Google Sheets', type: 'system')]` + `#[EcaAction(description, version_introduced: 1.0.0)]`,
uses `GoogleAuthActionConfigTrait` + `GoogleSheetsActionConfigTrait`, and in `create()` injects
`eca_google_sheets.google_sheets` and `eca_google.google_api`. Config schema: `config/schema/
eca_google_sheets.schema.yml` (`action.configuration.<id>` mappings). All string sinks below run
through `tokenService->replacePlain()` at execute time (fields marked `#eca_token_replacement`).

## Shared config (all actions)

From the traits: `auth_client_id` (required select "Google API Client", value `auth_type:client_id`),
`spreadsheet_id` (required textfield, token-aware; from the sheet URL), and — for most — `sheet_range`
(required textfield, default `Sheet1`, e.g. `Sheet1` or `Data!A1:C1`). Each `execute()` re-parses
`auth_client_id` via `googleApiService->parseAuthClientId()`, bails (logs) on missing/invalid config,
and (all except Append/Read) calls `googleSheetsService->validateApiAccess()` before acting.

## AppendToSheet — `eca_google_sheets_append_sheet`

Extra config: `row_data` (required textarea, one cell value per line), `value_input_option`
(`USER_ENTERED` default | `RAW`). `execute()` splits `row_data` on newlines, trims, builds a single
row, calls `GoogleSheetsService::appendToSheet(...)`.

## ReadFromSheet — `eca_google_sheets_read_sheet`

Extra config: `token_name` (required, default `sheet_data`), `headers_token_name`,
`count_token_name`, `skip_header_row` (bool), `use_header_as_keys` (bool). Calls `readFromSheet()`,
then post-processes: optionally shifts the header row; if *use header as keys*, rekeys each row by
header name, else rekeys columns to `Col1..ColN`; wraps rows as `Row1..RowN`; writes via
`tokenService->addTokenData($token_name, …)`, plus optional count and headers tokens. (Note: the
`empty($auth_type)/empty($client_id)` guard references vars set only after the check — a latent bug,
not a security issue.)

## QuerySheet — `eca_google_sheets_query_sheet`

Extra config: `query_expression` (required textarea, Google QUERY syntax, e.g. `SELECT * WHERE
Col1=34 AND Col3>100`), plus the same token/header options as Read. Calls `querySheet()` which runs a
server-side `=ARRAYFORMULA(QUERY(...))` in a temporary hidden tab (see sheets-service.md). Output adds
a `_ROW` key per row = the original spreadsheet row number, for use by UpdateSheet.

## UpdateSheet — `eca_google_sheets_update_sheet`

Extra config: `row_number` (required, token-aware, e.g. `[query_data:Row1:_ROW]`), `update_mode`
(`entire_row` | `specific_columns`), `row_data` (token holding a row array; used in entire-row mode),
`column_updates` (textarea, `column:value` per line; column = 1-based number or header name; used in
specific-columns mode), `headers_token` (token holding the header row, for header-name resolution).
`execute()` resolves headers, builds `$update_data` (indexed array or column-index map), strips any
`_ROW` key, then calls `updateSheet(...)`.

## CreateSheet — `eca_google_sheets_create_sheet`

Extra config: `sheet_title` (required, token-aware), `sheet_token_name` (optional). No `sheet_range`.
Calls `createSheet()`; on success optionally stores `{sheetId,title,index,sheetType,gridProperties}`
in the named token.

## ClearSheet — `eca_google_sheets_clear_sheet`

Config: auth + `spreadsheet_id` + `sheet_range` only. Calls `clearSheet()` (clears values, preserves
formatting).

## DeleteSheet — `eca_google_sheets_delete_sheet`

Extra config: `identifier_type` (`title` | `id`), `sheet_identifier` (required, token-aware). No
`sheet_range`. Calls `deleteSheet()` — permanently deletes the whole tab (form warns of this).

## Validation traits

`GoogleAuthActionConfigTrait::validateApiClientId()` checks the `auth_type:client_id` format.
`GoogleSheetsActionConfigTrait::validateSheetsAccess()` (in the submodule trait) is meant to confirm
Sheets API access via `validateApiAccess()`; note its `$auth_client_id` local is never assigned, so
the body is effectively skipped at form-validate time — runtime `validateApiAccess()` in each
`execute()` is the effective check.
