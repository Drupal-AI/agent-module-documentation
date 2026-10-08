<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expense Income Tracker (expense_tracker) — agent index

Records income/expense transactions as a fieldable content entity, with a category hierarchy, cron-driven
recurring entries, CSV/JSON/XML/XLSX bulk import, Highcharts reports/statements, and a REST API. Version 2.0.0
(version-dir 2.0.x). Core `^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later.

## Dependencies
Core: `views`, `comment`, `path`, `rest`, `serialization`, `basic_auth`. Contrib: `pathauto` (`^1.13`),
`views_bulk_operations` (`^4.3 || ^4.4`). Suggests `drupal/devel` for the DevelGenerate plugin.

## What it provides
- **Entity**: `et_transaction` (`src/Entity/EtTransaction.php`) — base_table `et_transaction`, data_table
  `et_transaction_field_data`; owner key `uid`, label `title`, published key `status`; translatable; Field UI base
  route `expense_tracker.settings`; admin permission `administer et_transactions`. Handlers: access
  (`EtTransactionAccessControlHandler`), storage (`EtTransactionStorage`), list builder, view builder, views_data,
  forms (default/edit/delete/delete_transaction/delete_items).
- **Config**: `expense_tracker.settings` (Highcharts source + currency) via `EtTransactionSettingsForm`; schema in
  `config/schema/expense_tracker.schema.yml`.
- **Permissions** (`expense_tracker.permissions.yml`): `create`/`edit`/`delete`/`access`/`edit all`/`delete all`/
  `access all`/`config`/`reports`/`import expense_tracker`, `administer et_transactions`, plus REST `restful *`.
- **Routes** (`expense_tracker.routing.yml`): entity CRUD/canonical, settings, import, reports hub + income/expense/
  combined chart routes, statements.
- **REST resource plugins** (`src/Plugin/rest/resource/`): `et_transaction` (CRUD), `et_transaction_collection`
  (GET list), `et_transaction_import` (POST bulk).
- **Other plugins**: pathauto `AliasType` (`et_transaction`), DevelGenerate (`EtTransaction`).
- **Services** (`expense_tracker.services.yml`): `expense_tracker.excel_reader` (`ExcelReaderService`),
  `expense_tracker.post_render_cache`, `logger.channel.expense_tracker`.
- **Hooks provided** (`expense_tracker.api.php`): `hook_et_transaction_api_normalize_alter`,
  `_api_create_alter`, `_api_update_alter`, `_collection_query_alter`, `_import_row_alter`. Also implements
  tokens (`[et_transaction:*]`), cron, theme, form_alter, views_query_alter, preprocess hooks.

## Solution docs
- [entity/et_transaction.md](entity/et_transaction.md) — entity definition, fields, storage, access model, forms.
- [config/settings.md](config/settings.md) — settings form, config object/schema, install/enable, cron/repeat.
- [api/rest.md](api/rest.md) — REST resources, endpoints, filters, alter hooks.
- [features/pages.md](features/pages.md) — reporting/statements controller, import form, ExcelReaderService, plugins & integrations.
