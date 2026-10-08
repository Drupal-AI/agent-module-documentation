<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA: Google Sheets (eca_google_sheets) — agent index

Submodule of **ECA: Google**. Adds **7 ECA action plugins** for Google Sheets. Package `ECA`.
Depends on `eca_google` (→ `eca`, `google_api_client`). Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.0. Provides config schema for the 7 actions; **no routes, permissions, hooks or Drush.**

- **All 7 actions: ids, config fields, execute flow, token output syntax** →
  [plugins/actions.md](plugins/actions.md)
- **`eca_google_sheets.google_sheets` service (Sheets API wrapper) + config trait** →
  [api/sheets-service.md](api/sheets-service.md)
- Shared auth layer (parent module) → [../../../../1.0.x/agent/api/google-api-service.md](../../../../1.0.x/agent/api/google-api-service.md)

## The 7 actions (`src/Plugin/Action/`)

| Action id | Class | Purpose |
|---|---|---|
| `eca_google_sheets_append_sheet` | `AppendToSheet` | Append one row (one cell per line) |
| `eca_google_sheets_read_sheet` | `ReadFromSheet` | Read a range into tokens |
| `eca_google_sheets_query_sheet` | `QuerySheet` | Server-side QUERY filter into tokens |
| `eca_google_sheets_update_sheet` | `UpdateSheet` | Update a row (entire row / specific columns) |
| `eca_google_sheets_create_sheet` | `CreateSheet` | Add a tab to a spreadsheet |
| `eca_google_sheets_clear_sheet` | `ClearSheet` | Clear a range (keeps formatting) |
| `eca_google_sheets_delete_sheet` | `DeleteSheet` | Delete an entire tab |

All extend `Drupal\eca\Plugin\Action\ConfigurableActionBase`, carry `#[Action]` + `#[EcaAction]`
attributes, category "Google Sheets", and use `GoogleAuthActionConfigTrait` +
`GoogleSheetsActionConfigTrait`. Each injects `eca_google_sheets.google_sheets` and
`eca_google.google_api` in `create()`.

## Service

- `eca_google_sheets.google_sheets` → `Drupal\eca_google_sheets\GoogleSheetsService`
  (`src/GoogleSheetsService.php`), args `@eca_google.google_api`, `@logger.factory` (channel
  `eca_google_sheets`). Wraps `Google\Service\Sheets` calls; returns bool/array/NULL, logging
  failures. See [api/sheets-service.md](api/sheets-service.md).

## Token output syntax (Read / Query)

Data lands in ECA tokens as `Row1..RowN` → `Col1..ColN` (or header names when *Use Header as Keys*).
`[data:Row1:Col1]`, `[data:Row2:Name]`; Query adds `[data:Row1:_ROW]` = original spreadsheet row.

## Install

Enable `eca_google` + this module; enable the Google Sheets API in the linked Google Cloud project;
configure an OAuth2 client or Service Account in `google_api_client`. Build models in the ECA UI
(requires ECA's own admin permission).
