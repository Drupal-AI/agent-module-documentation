<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `order_by_delta` Views sort handler

The module ships exactly one Views plugin — a **sort handler** — plus the `hook_views_data()` that
exposes it. There is no plugin *type* to implement and nothing to subclass; you use it entirely from
the Views UI.

## How it is registered (`views_order_by_delta.views.inc`)

`hook_views_data()` walks every entity type that declares a `views_data` handler. For each field
storage of type **`entity_reference`** it resolves the dedicated data table
(`$storage->getTableMapping()->getDedicatedDataTableName($field)`) and, if that table has a `delta`
column, adds a Views field on the entity's **base table**:

```php
$data[$entity_type->getBaseTable()][$table_name . '__views_order_by_delta'] = [
  'title' => t('Order by delta (using @field)', ['@field' => $field->getName()]),
  'help'  => t('Custom sort.'),
  'sort'  => ['id' => 'order_by_delta'],
  'real field' => 'delta',
];
```

So each eligible reference field yields one sort criterion named **"Order by delta (using
{field_name})"**, keyed `{data_table}__views_order_by_delta`, resolving to the `delta` column via
`real field`. Verified live on a stock site: only the two `entity_reference` fields present
(`taxonomy_term.parent`, `user.roles`) produced sorts (`taxonomy_term__parent__views_order_by_delta`,
`user__roles__views_order_by_delta`). **Only `entity_reference` is covered** — multi-value text and
`entity_reference_revisions` (Paragraphs) fields are skipped.

## The handler (`src/Plugin/views/sort/OrderByDelta.php`)

`@ViewsSort("order_by_delta")`, extends `SortPluginBase`, `usesGroupBy()` → `FALSE`. Its `query()`:

- Derives the field table name by stripping the `__views_order_by_delta` suffix from `$this->field`.
- Scans `$this->query->tables` for that table and grabs its **alias** — it does NOT call
  `ensureTable()`. This is deliberate: the handler has no table of its own and relies on the
  relationship's join already being present. If the relationship is removed the table is absent, so
  the handler simply **adds no ORDER BY** rather than forcing a fresh join (which would re-create the
  duplicate-rows problem the module exists to avoid).
- When the alias is found: `$this->query->addOrderBy($table_alias, $this->realField /* 'delta' */,
  $this->options['order'])` (Views' ASC/DESC option).

## Using it in a view

1. Create a view listing the **referenced** entities (e.g. nodes).
2. Add a **Relationship** built on the multi-value `entity_reference` field that bridges to those
   entities — this is what joins `{data_table}` into the query.
3. Add the **Sort criterion** "Order by delta (using {field})" and point it at that relationship;
   choose ASC or DESC.

Without step 2 the sort is inert (the join is absent, so `query()` no-ops). This is the intended way
to get per-reference editorial order without the row duplication Views' native `field:delta` sort
causes across a relationship.
