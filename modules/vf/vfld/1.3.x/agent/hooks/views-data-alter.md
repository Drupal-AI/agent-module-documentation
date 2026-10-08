# `hook_views_data_alter` — the "Last Delta" filters

File: `vfld.views.inc` → `vfld_views_data_alter(array &$data): void`.

## What it does

It walks every table in the Views data array. For any column literally named `delta` that already
has `$data[$table]['delta']['filter']['field_name']` set (i.e. a real multi-value field-data/revision
table), it creates a **sibling** filter definition on the same table:

```php
$data[$table_name]['delta_vfld'] = [
  'title' => t('@label (last)', ['@label' => (string) $column['delta']['title']]),
  'group' => t('Last Delta'),
  'filter' => [
    'field'            => 'vfld',
    'table'            => $table_name,
    'id'               => 'vfld',              // -> LastDeltaFilter
    'additional fields'=> [],
    'field_name'       => $column['delta']['filter']['field_name'],
    'entity_type'      => $column['delta']['filter']['entity_type'],
    'allow empty'      => TRUE,
  ],
];
```

So the new handler is keyed `{table}.delta_vfld`, grouped under **Last Delta**, and titled
`<original delta title> (last)`. It is only offered for tables Views already exposes a `delta`
filter on — you will not see it for single-value fields.

## How an agent uses it (adding the filter to a view)

1. The multi-value field must be added to the view as a field, and (per README) the field's
   "Display all values in the same row" option should be **unticked** so each delta is its own row.
2. Add a filter; in the **Last Delta** category pick the `… (last)` entry for the target field.
3. Set the filter value to **Yes** to activate it (see
   [../plugins/last-delta-filter.md](../plugins/last-delta-filter.md)). It can be exposed like any
   other filter.

In a `views.view.*` config export the filter appears with `plugin_id: vfld`, `field: delta_vfld`,
`value: 1`, `entity_type` / `field_name` carried from the table definition.

## Notes

- The handler reuses the source column's `entity_type` and `field_name`; `LastDeltaFilter::query()`
  needs `entity_type` to resolve the base-entity id key for its correlated subquery.
- No other hooks are implemented by the module.
