<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How custom tables become Views data

`view_custom_table_views_data()` (in `view_custom_table.module`) implements `hook_views_data()`.
It reads every entry in the `view_custom_table.tables` config, and for each registered table:

1. Loads the live column list with `view_custom_table_load_table_structure($table, $db)`, which
   queries `information_schema.columns` on the entry's `table_database` connection (prefix-aware).
2. Marks the table as a Views **base table**:
   `$data[<table>]['table']['base'] = ['field' => <first column>, 'title' => …, 'database' => <db>, 'weight' => 10]`
   and groups it under **`Custom Table Views`** (`$data[<table>]['table']['group']`).
3. Maps each column to Views handlers **by SQL type** (`simplifyType()` normalizes the type):

| Column SQL type | field | sort | filter | argument |
|---|---|---|---|---|
| integer/numeric (`int`, `bigint`, `decimal`, `float`, `boolean`, `numeric`, …) | `numeric` | `standard` | `numeric` | `numeric` |
| text (`varchar`, `char`, `text`, `json`, `enum`, …) | `standard` | `standard` | `string` | `string` |
| date/time (`date`, `datetime`, `timestamp`, `time`, `year`) | **`mysql_date`** | — | **`mysql_date`** | — |

## The `mysql_date` handlers (the module's only Views plugins)

- `Drupal\view_custom_table\Plugin\views\field\MysqlDate` — `@ViewsField("mysql_date")`, extends
  `FieldPluginBase`; formats a raw DB date/time column using Drupal date formats + timezone.
- `Drupal\view_custom_table\Plugin\views\filter\MysqlDate` — `@ViewsFilter("mysql_date")`, extends
  core Views `Date` filter, so custom-table date columns get the standard date operators.

These are the only Views plugins the module ships; it does **not** define a Views plugin *type*.

## Relationships (from `column_relations`)

If a column is listed in the entry's `column_relations`:

- **Column → entity type** (e.g. `uid => user`): adds
  `$data[<table>][<column>]['relationship']` with `id => 'standard'`, `base` = the entity's data
  table (or base table; `file` is special-cased to `file_managed`), and `base field` = the
  entity's id key. It also adds a **reverse** relationship
  (`id => 'entity_reverse'`) from the entity's base table back to the custom table.
- **Column → another custom table**: adds a `standard` relationship joining to that table on its
  primary key (both tables must be in the same `database`).

## Operational notes

- Views data is cached — after any registration/relation change, clear it
  (`\Drupal::service('views.views_data')->clear()` or `drush cr`) or the base table won't appear.
- A registered table with no primary key, or a non-numeric relation column, will not behave
  correctly — these are the module's stated requirements.
- To read the resolved Views data for a table programmatically:
  `\Drupal::service('views.views_data')->get('<table>')` — `['table']['base']` confirms it is a
  usable base table.
