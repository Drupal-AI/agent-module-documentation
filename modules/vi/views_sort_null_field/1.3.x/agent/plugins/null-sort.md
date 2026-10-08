<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `null_sort` Views sort handler

The module is two files: the plugin `src/Plugin/views/sort/NullSort.php` and
`views_sort_null_field.views.inc` (which exposes the handler in Views data). There is no plugin
manager of its own — it plugs into core's existing `ViewsSort` plugin type.

## How the sort is exposed

`hook_field_views_data_alter()` iterates the columns of every Field API field storage and, for each
column that **can be NULL** (it skips columns with `not null` and skips fields with custom storage),
adds a synthetic sort:

```
$data['<entity>__<field>']['<column>_null_sort'] = [
  'title'      => '<Label> (<field>) null sort',
  'title short'=> '<Label> null sort',
  'help'       => 'Sort entities with no value (NULL) last or first.',
  'sort' => ['field' => '<column real name>', 'id' => 'null_sort'],
];
```

So for an integer field `field_weight` on nodes you get a sort named **`field_weight_value_null_sort`**
on table `node__field_weight`. Single-column fields (or the `value` column) are labelled
"`<Label> null sort`"; extra columns of multi-column fields are labelled "`<Label>:<column> null sort`".

## What the handler does

`NullSort::query()` adds an ORDER BY on an expression, not a real column:

```php
$this->query->addOrderBy(NULL, "$this->tableAlias.$this->realField IS NULL", $this->options['order'], $alias);
```

`<table>.<column> IS NULL` evaluates to **1 for empty rows, 0 for populated rows**. Therefore:

- **ASC** → 0 before 1 → **populated first, NULLs last** (labelled "Sort NULL last" / summary "NULL last").
- **DESC** → 1 before 0 → **NULLs first** (labelled "Sort NULL first" / summary "NULL first").

`sortOptions()` renames the ASC/DESC radios to "Sort NULL last" / "Sort NULL first". The handler is
exposable like any Views sort.

## The two-sort recipe

The null sort only buckets empty vs non-empty; it does not order *within* a bucket. To get a fully
ordered list with empties last, add **two** sorts, in this order:

1. `field_weight_value_null_sort` — order **ASC** (NULLs last).
2. `field_weight` (the normal field sort) — order **ASC** (or as desired).

## Adding it to a view in config (scriptable)

A sort entry in a display's `display_options.sorts` looks like:

```yaml
sorts:
  field_weight_value_null_sort:
    id: field_weight_value_null_sort
    table: node__field_weight
    field: field_weight_value_null_sort
    plugin_id: null_sort
    order: ASC        # ASC = NULL last, DESC = NULL first
    relationship: none
    exposed: false
```

Load the `view` config entity, set the display's `sorts`, and save; or add the "… null sort" sort
through the Views UI (Sort criteria → Add) and pick "Sort NULL last" / "Sort NULL first".
