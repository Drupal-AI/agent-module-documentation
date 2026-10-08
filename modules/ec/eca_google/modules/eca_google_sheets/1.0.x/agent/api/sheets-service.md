<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eca_google_sheets.google_sheets service + config trait

Source: `src/GoogleSheetsService.php`, `src/GoogleSheetsActionConfigTrait.php`,
`eca_google_sheets.services.yml`.

## Service registration

```
eca_google_sheets.google_sheets:
  class: Drupal\eca_google_sheets\GoogleSheetsService
  arguments: ['@eca_google.google_api', '@logger.factory']
```

Logger channel: `eca_google_sheets`. Constants: `VALUE_INPUT_USER_ENTERED`/`VALUE_INPUT_RAW`,
`UPDATE_MODE_ENTIRE_ROW`/`UPDATE_MODE_SPECIFIC_COLUMNS`.

## Resolving the Sheets client

- `getSheetsService(string $auth_type, string $client_id): ?Sheets` — delegates to
  `GoogleApiService::getService('sheets', …)` and returns the `Google\Service\Sheets` object (or NULL).
- `validateApiAccess(string $auth_type, string $client_id): bool` — proxies
  `GoogleApiService::validateApiAccess('sheets', …)`.

Every operation below first calls `getSheetsService()`, returns a failure value if NULL, and wraps the
Google call in try/catch, logging the exception message and returning bool FALSE / NULL on error.

## Operations

- `appendToSheet($auth_type, $client_id, $spreadsheet_id, $range, array $values, $value_input_option
  = USER_ENTERED): bool` — `spreadsheets_values->append()` with a `ValueRange`.
- `readFromSheet(...): ?array` — `spreadsheets_values->get()`, returns `getValues()` (or `[]`).
- `querySheet($auth_type, $client_id, $source_spreadsheet_id, $source_range, $query_expression,
  int $sleep_time = 2): ?array` — creates a temporary **hidden** tab
  (`ECA_Query_Temp_<uniqid>`) via `batchUpdate(addSheet)`; normalises the range (adds sheet name /
  detects data bounds from grid properties, converting column counts to letters); writes
  `=ARRAYFORMULA(QUERY({<range>, ROW(<range>)}, "<query_expression>", 1))` into the temp tab;
  `sleep($sleep_time)` for Google to compute; reads results; renames the last column header to `_ROW`;
  then deletes the temp tab (and deletes it again in the catch block on error).
- `updateSheet($auth_type,$client_id,$spreadsheet_id,$sheet_range,int $row_number,array $update_data,
  $update_mode): bool` — entire-row → `spreadsheets_values->update()` on `range!row:row`;
  specific-columns → one `ValueRange` per column (`getColumnLetter()` maps 0-based index → A, B, …,
  AA) sent via `spreadsheets_values->batchUpdate()`.
- `createSheet(...): ?array` — `batchUpdate(addSheet)`; returns `sheetId,title,index,sheetType,
  gridProperties{rowCount,columnCount}`.
- `clearSheet(...): bool` — `spreadsheets_values->clear()` (formatting preserved).
- `deleteSheet($auth_type,$client_id,$spreadsheet_id,$sheet_identifier,$identifier_type='title'):
  bool` — resolves the numeric sheetId (direct when `id`, else `getSheetIdByTitle()` scans
  `spreadsheets->get()` metadata) and `batchUpdate(deleteSheet)`.
- `getValueInputOptions(): array` — the two value-input options for the Append form select.

Private helpers: `getSheetIdByTitle()`, `getColumnLetter()`.

## `GoogleSheetsActionConfigTrait`

- `getSpreadsheetIdDefaultConfig()` → `['spreadsheet_id' => '']`;
  `getSheetRangeDefaultConfig()` → `['sheet_range' => 'Sheet1']`.
- `addSpreadsheetIdConfigurationForm()` / `addSheetRangeConfigurationForm()` — required, token-aware
  textfields.
- `validateSheetsAccess()` — intended to call `validateApiAccess()`, but its `$auth_client_id` is
  never populated, so the check is skipped at form validate; the effective Sheets-access check is the
  runtime `validateApiAccess()` call inside each action's `execute()`.
