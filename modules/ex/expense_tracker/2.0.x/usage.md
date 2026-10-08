<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Records income and expense transactions as a fieldable Drupal content entity, with recurring entries, bulk file import, Highcharts reports and a REST API.

---

Expense Income Tracker (machine name `expense_tracker`, package "Expense and income tracker") defines a dedicated
content entity, `et_transaction`, that stores a title, amount, transaction date, type (income/expense), optional
note, owner (uid), published status, an optional parent-category reference, and a set of repeat/scheduling fields.
Entries are created through a two-column admin form at `/admin/income-expense-transactions/add`, browsed in a Views
listing (`expense_tracker_admin`) at `/admin/income-expense-transactions`, and viewed at `/et-transaction/{id}`.
A cron-driven repeat system (`hook_cron` → `expense_tracker_repeat_transactions()`) auto-clones transactions on
day/week/month/year, working-days, specific-weekday and specific-monthday schedules until an end date. Data can be
bulk-imported from CSV, JSON, XML or XLSX via a Batch-API upload form (`ImportDataForm`, XLSX handled by the
injectable `expense_tracker.excel_reader` service) or seeded from a bundled 60-row demo dataset from the settings
form. Reporting pages render interactive Highcharts income/expense charts and tabular statements grouped by day,
week, month, quarter or year, with currency symbol, position and separators configurable in
`expense_tracker.settings`. A REST API exposes single-record CRUD (`/api/et-transactions/{id}`), a
filterable/paginated collection (`/api/et-transactions`) and a bulk import endpoint
(`/api/et-transactions/import`), all extensible through the module's alter hooks. It depends on core views,
comment, path, rest, serialization and basic_auth, plus contrib pathauto and views_bulk_operations.

---

- Track personal or household income and expenses inside a Drupal site.
- Run a small-business cash-flow or petty-cash ledger with income and expense records.
- Provide a corporate expense-reporting portal backed by a proper content entity.
- Categorise transactions by attaching child entries to a parent "category" transaction (e.g. Rent, Salary).
- Automatically generate recurring bills or paychecks on a daily, weekly, monthly or yearly schedule via cron.
- Schedule custom recurrences on working days, specific weekdays, or specific days of the month.
- Set an end date after which a recurring transaction stops generating copies.
- Bulk-import historical transactions from a CSV, JSON, XML or XLSX file.
- Parse XLSX workbooks without installing PhpSpreadsheet or any extra Composer package.
- Download ready-made CSV/JSON/XML/XLSX sample files to learn the required import columns.
- Seed a demo/test site with 60 realistic sample transactions spanning 2025–2026.
- Visualise income, expense or combined trends as interactive Highcharts charts.
- View tabular income/expense statements filtered by date range, author and category.
- Format displayed amounts with a configurable currency symbol, position and thousands/decimal separators.
- Serve Highcharts from bundled local files, the jsDelivr CDN, or a custom URL with optional local fallback.
- Expose transactions to a decoupled frontend or mobile app through a JSON REST API.
- Create, read, update and delete individual transactions over REST with cookie or Basic Auth.
- Query, filter, sort and paginate transactions through the REST collection endpoint.
- Bulk-import transaction rows programmatically via the REST import endpoint.
- Add custom fields to transactions through Field UI and map them in imports/API via alter hooks.
- Give each transaction a comment thread using the auto-installed `et_transaction_comment` comment type.
- Generate SEO-friendly URL aliases for transactions with Pathauto tokens.
- Apply Views Bulk Operations to act on many transactions at once from the admin list.
- Reassign transaction ownership to another user when entering records on behalf of a team member.
- Unpublish a disputed or draft transaction to exclude it from reports, charts and API output.
