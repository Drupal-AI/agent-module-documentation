<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter plugin `unified_datetime`

`src/Plugin/views/filter/UnifiedDatetime.php` — `@ViewsFilter("unified_datetime")`, extends core
`Drupal\views\Plugin\views\filter\Date`. It is "a copy of the default date handler but with a custom
group form".

## Wiring

`ViewsHook::viewsDataAlter()` (`hook_views_data_alter`) sets
`$data['node_field_data']['unified_date']['filter']['id'] = 'unified_datetime'`, so a filter added on
the `unified_date` field uses this plugin. (Sorting and other handlers stay the core defaults; only
the filter is swapped.) Config schema for the filter/value: `config/schema/unified_date.filter.schema.yml`
(`views.filter.unified_datetime` inherits `views.filter.date`; adds `expose.min_label`,
`expose.max_label`, `group_info.custom_range`).

## What it adds over core `Date`

- `defineOptions()`: `group_info.custom_range` (bool), and `expose.min_label` / `expose.max_label`
  strings.
- `buildOptionsForm()`: when grouped, an "Add custom range" checkbox; when exposed, Min/Max label
  textfields.
- `valueForm()`: applies the custom min/max labels; adds a **`Strtotime`** value type; sets exposed
  min/max/value inputs to HTML `#type => 'date'`.
- `groupForm()`: renders grouped items with a "Specific dates" option (`custom`) plus min/max text
  inputs shown via `#states` when `custom` is selected.
- `acceptExposedInput()` / `convertExposedInput()`: translate the custom-range group selection into a
  `between` / `>` / `<` operator with the entered min/max.
- `opBetween()` / `opSimple()`: for `strtotime`/`date` value types, build the WHERE with
  `intval(strtotime(...))` bounds (the max is extended to `… 23:59:59`) using
  `addWhereExpression()`; otherwise defer to the parent.

## Usage

Add a filter (or exposed filter) on the node **Unified date** field in a View. For a public
date-range picker, expose it, optionally set Min/Max labels, and choose the range operator. For
grouped filters, enable "Add custom range" to let users enter specific dates. Because the field is a
plain `timestamp` base field on `node_field_data`, sorting a View by Unified date needs no special
handler — add it as a normal sort.
