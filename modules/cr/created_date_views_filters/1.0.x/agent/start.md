<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Created Date Views Filters (created_date_views_filters) — agent index

Provides **two Views filter handlers** on the entity `created` timestamp: a **Year** dropdown and
a **Month** dropdown. Depends on core `views`. No configuration outside the Views UI. Version
**1.0.6**. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it actually does

`created_date_views_filters.module` implements `hook_views_data()` and registers two filters on the
`views` pseudo-table against `field => 'created'`:

| Views id       | Class        | UI element                         | Query it adds |
|----------------|--------------|------------------------------------|---------------|
| `year_filter`  | `YearFilter`  | `<select>` of `date('Y')-5` → current year (default current year) | `EXTRACT(YEAR FROM FROM_UNIXTIME($table.created)) = :year` |
| `month_filter` | `MonthFilter` | `<select>` of month names January–December | `EXTRACT(MONTH FROM FROM_UNIXTIME($table.created)) = :month` |

Both classes extend `\Drupal\views\Plugin\views\filter\FilterPluginBase` (the plain base — **no**
operator, min/max, or between UI; just one value). `MonthFilter` maps the selected month *name* to a
number via `date('m', strtotime($value))` before binding. `$table` is
`array_key_first($this->query->tables)` — the View's **first** table.

## Key facts for answering questions

- **Month matches every year.** Selecting "March" returns March of *all* years; pair it with the
  Year filter (they AND) to scope to a single month of a single year.
- **Year list is a rolling 6-year window** (current year and the five before it); no way to pick
  earlier years from the dropdown.
- **DB-specific SQL.** `EXTRACT(... FROM FROM_UNIXTIME(...))` is MySQL/MariaDB syntax; it will not
  run on PostgreSQL or SQLite.
- **Table-targeting caveat (correctness, not security).** The filters key off the View's *first*
  table, not the table that owns `created`; on Views whose base table is not the timestamp's owner
  (or whose first table is aliased) the generated SQL can reference the wrong/absent column.
- **No config, schema, permissions, services, Drush, or admin form.** Everything is set per-View in
  the Views UI. The filters can be exposed like any other Views filter.

## Files

- `created_date_views_filters.module` — `hook_views_data()` registering both filters.
- `src/Plugin/views/filter/YearFilter.php` — `@ViewsFilter("year_filter")`, `valueForm()` + `query()`.
- `src/Plugin/views/filter/MonthFilter.php` — `@ViewsFilter("month_filter")`, `valueForm()` + `query()`.

See `views/filters.md` for handler details, `usage.md` for use cases, `data.json` for metadata.
