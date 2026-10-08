<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reporting pages, statements, file import & integrations

## Charts & statements
Routes (all `_permission: reports expense_tracker`):
- `expense_tracker.configurations` (`/admin/expense-tracker-reports`) — hub (core
  `SystemController::systemAdminMenuBlockPage`).
- `expense_tracker.like_configurations` (`/admin/expense-tracker/income-expense-statements`) — `StatemantsForm`,
  a date-range/type filter that redirects into the `expense_tracker_admin` View with `from`/`to`/`transaction_type`
  query args (`referrer=statements`).
- `expense_tracker.income_reports` / `expense_reports` / `income_expense_reports` — all handled by
  `EtTransactionController::reports()`.

`EtTransactionController::reports()` (`src/Controller/EtTransactionController.php`) selects behaviour from the route
name and a `filter` request param (this_week default; last_seven_days, last_thirty_days, this/last week/month/
quarter/year, all). For each period bucket it calls the global helper `expense_tracker_get_total_amounts()` and
builds `categories`/`series` for a Highcharts theme (`income_reports` or `income_expense_reports`,
templates in `templates/`). It also reads `author` and `category` request filters (see `ReportFilterForm`, a GET
form with user + et_transaction autocompletes) and attaches currency data + the Highcharts library
(local/cdn/fallback) plus `expense_tracker/expense_tracker.reports` and `drupalSettings.expenseTracker`.

`expense_tracker_get_total_amounts($params)` (in `expense_tracker.module`) runs an entity query over `et_transaction`
between `start_timestamp`/`end_timestamp`, optionally narrowed by `transaction_type`, `author` (uid parsed from the
`Label (uid)` autocomplete string via `expense_tracker_get_substring_between()`) and `category`, then sums amounts
and groups child transactions under their parent category id, returning `{total_amount, transaction_details}`.

## File import (`ImportDataForm`)
Route `expense_tracker.import_transactions` (`/admin/expense-tracker/import/transactions`, form id
`import_data_form`, permission `import expense_tracker`). Accepts a `managed_file` upload restricted to
`json xml csv xlsx` (validator `FileExtension`), uploaded to `public://temp-lms-files/import-files/`. On submit it
re-validates the extension against an allowlist before dispatching to a parser (`getJsonImportData`,
`getXmlImportData` via `SimpleXMLElement`, `getCsvImportData` via `fgetcsv`, `getXlsxImportData` via the
`expense_tracker.excel_reader` service). `validateImportData()` requires header columns `title, amount, date, type`
(`note` optional). Rows are queued through Drupal Batch API: `expense_tracker_mapped_data()` builds operations,
`expense_tracker_perform_batch_action()` creates each transaction (attaching as a child when a matching `new`
parent-category title already exists), and `expense_tracker_batch_finished_callback()` summarises the count. Sample
files are downloadable from the form (`assets/sample-files/et_transaction.{csv,json,xml,xlsx}`).

## ExcelReaderService
`src/Service/ExcelReaderService.php` (service `expense_tracker.excel_reader`, final class) is a self-contained
Office Open XML (.xlsx) reader — no PhpSpreadsheet/Composer dependency. `parseFile()` / `parseData()` open a
workbook; `rows()`, `readRows()`, `getCell()`, `sheetNames()`, `excelDateToUnix()`, `toHtml()` etc. expose the
parsed data; `getLastError()`/`isSuccess()` report status. Constructed with the module logger channel.

## Other integrations (`expense_tracker.module` + plugins)
- **Tokens**: `hook_token_info`/`hook_tokens` expose `[et_transaction:id|title|type|date|author]` (date/author
  chain to core date/user tokens) — used by Pathauto.
- **Pathauto**: `src/Plugin/pathauto/EtTransactionAliasType.php` (`@AliasType id = et_transaction`) registers the
  entity for URL-alias patterns.
- **DevelGenerate**: `src/Plugin/DevelGenerate/EtTransactionDevelGenerate.php` (`id = EtTransaction`,
  url `generate-transaction`) bulk-generates sample transactions when `devel` is installed.
- **Views**: `expense_tracker_admin` View + `EtTransactionViewData`; `hook_views_query_alter` corrects the
  date-range filter boundaries and, for users without `access all expense_tracker`, adds a `uid = current user`
  condition; `hook_form_views_exposed_form_alter` turns the from/to filters into HTML5 date inputs.
- **Menu/tasks/actions**: `expense_tracker.links.{menu,task,action}.yml` wire admin menu entries, local tabs and
  action buttons across the transaction list, settings, import and page views.
- **Post-render cache**: `EtTransactionPostRenderCache` service (`expense_tracker.post_render_cache`) — render
  helper injected with entity_type.manager, class_resolver, form_builder and request_stack.
