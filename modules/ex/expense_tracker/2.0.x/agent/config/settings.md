<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configuration & recurring transactions

## Install / enable
`drush en expense_tracker -y` (or via the UI). Requires core `views`, `comment`, `path`, `rest`, `serialization`,
`basic_auth` and contrib `pathauto`, `views_bulk_operations`. `config/install/` ships the settings object, the
`et_transaction_comment` comment type + `comment_body` field, the teaser view mode, the `expense_tracker_admin`
View, and three `rest.resource.*` configs. `expense_tracker.install`:
- `hook_requirements()` (runtime): warns if `highcharts_source = local` but `js/highcharts.src.js` /
  `js/exporting.js` are missing.
- `expense_tracker_update_9005()`: idempotent setup of settings defaults, comment type/field, and form/view displays.
- `expense_tracker_update_9006()`: enables `basic_auth`, activates the three REST resource configs
  (`granularity: method`, formats `json`, auth `cookie` + `basic_auth`) and grants the `restful *` permissions to
  the `administrator` role.

## Config object `expense_tracker.settings`
Schema `config/schema/expense_tracker.schema.yml` (type `config_object`). Keys / install defaults:
- `highcharts_source` (string) — `local` | `cdn` | `custom` (default `local`).
- `highcharts_cdn_fallback` (bool, default true) — inject local fallback if the CDN fails.
- `highcharts_cdn_version` (string, default `12.4.0`) — jsDelivr npm version segment.
- `highcharts_custom_url` / `highcharts_exporting_custom_url` (string) — used when source = `custom`.
- `currency_symbol` (string, default `$`), `currency_position` (`before`|`after`, default `before`),
  `decimal_separator` (default `.`), `thousands_separator` (default `,`).

## Settings form `EtTransactionSettingsForm` (`ConfigFormBase`)
Route `expense_tracker.settings` at `/admin/config/content/et-transaction`, permission `config expense_tracker`,
form id `et_transaction_settings`. Three sections: Highcharts source (radios + `#states`-gated CDN/custom fields,
validated with `FILTER_VALIDATE_URL`), Currency display, and Sample Data. The Sample Data section imports/removes a
bundled 60-row demo dataset (`assets/sample-files/et_transaction_demo.json`) via `submitImportSampleData()` /
`submitClearSampleData()`, deduplicating on title+date+type. Changing the Highcharts source requires a cache clear —
`expense_tracker_library_info_alter()` rewrites the `highcharts.cdn` library URLs from config, and
`expense_tracker_page_attachments()` attaches base + responsive admin CSS on every `expense_tracker.*` /
`entity.et_transaction.*` route.

## Recurring transactions (cron)
`hook_cron` → `expense_tracker_repeat_transactions()` calls `expense_tracker_repeat_transactions_every($type)` for
each frequency. For each matching source transaction (`repeat = 1`, matching `repeat_every`, `last_transaction_time`
older than the interval, `end_date` in the future) it `createDuplicate()`s the entity, sets
`parent_transaction_id`, `date = now`, `transaction_category = existing`, `created_type = automatic`, saves the
copy, and stamps `last_transaction_time` on the source. `working_days`/`specific_week_days`/`specific_month_days`
additionally check the current day against the configured allowed days. Cron must run at least daily for schedules
to be honoured.

## Permissions (`expense_tracker.permissions.yml`)
`create` / `edit` / `delete` / `access` expense_tracker (own records with the matching operation on the entity),
`edit all` / `delete all` / `access all` expense_tracker (all records), `config expense_tracker` (settings),
`reports expense_tracker` (report/statement pages), `import expense_tracker` (import form + REST import),
`administer et_transactions` (restricted; full admin incl. Field UI), and the auto-generated REST `restful *`
permissions.
