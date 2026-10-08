# Configure the allowed-values sort

## In the Views UI

1. The View must have a **List (text)** (`list_string`) field available (its bundle in the base).
2. Add a **Sort criterion** on that field (the `…: (field_name)` sort).
3. In the sort settings you now see two extra options:
   - **Sort by allowed values** → set to **Yes** to enable allowed-values ordering.
   - **Treat null values as heavier than the allowed values** → Yes to push empty values last.
4. Set the sort **order** (ASC/DESC) as usual and save.

The option only *does* anything when "Sort by allowed values" is Yes; otherwise the handler sorts
normally (`query()` returns early).

## Options (`SortAllowedValues::defineOptions()`)

| Option | Default | Effect |
|---|---|---|
| `allowed_values` | 0 | 0 = No (normal sort), 1 = Yes (order by allowed-values index). |
| `null_heavy` | 0 | 1 = reverse the FIELD ordering so null/unknown values sort last. |

## How it sorts (`query()`)

Builds `FIELD(<alias>.<column>, 'key1', 'key2', …)` from
`array_keys(options_allowed_values($field_storage))` (keys quoted via the DB connection), then
`addOrderBy(NULL, $formula, $order, …)`. With `null_heavy` on, the allowed values are reversed and
the formula is prefixed with `-1 *` so `0`/empty is heaviest. This yields ordering by the position
of each stored key in the field's defined allowed-values list.

## Where it is stored (view config entity)

```yaml
display:
  default:
    display_options:
      sorts:
        field_priority_value:
          id: field_priority_value
          table: node__field_priority
          field: field_priority_value
          plugin_id: sort_allowed_values     # provided by this module
          order: ASC
          allowed_values: '1'                 # the toggle
          null_heavy: '0'
          entity_type: node
          entity_field: field_priority
```

Set with drush (field must already exist so its Views data is present):

```bash
drush php:eval '
  $v = \Drupal\views\Entity\View::load("my_view");
  $d = $v->getDisplay("default");
  $d["display_options"]["sorts"]["field_priority_value"] = [
    "id" => "field_priority_value", "table" => "node__field_priority",
    "field" => "field_priority_value", "relationship" => "none",
    "plugin_id" => "sort_allowed_values", "order" => "ASC",
    "allowed_values" => "1", "null_heavy" => "0",
    "entity_type" => "node", "entity_field" => "field_priority",
  ];
  $v->set("display", ["default" => $d] + $v->get("display"))->save();
'
```
