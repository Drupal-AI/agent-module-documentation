# The weighted sort handlers

All configuration happens inside a View (needs `administer views`). There is no global settings
page, permission, or Drush command.

## The three handlers

| Sort id | Class | Applies to | Value list source |
|---|---|---|---|
| `extended_sort_by_options_weight` | `ExtendedSortByOptionsWeight` | `list_string` / `list_integer` / `list_float` fields | `options_allowed_values()` of the field storage |
| `extended_sort_by_bundles_weight` | `ExtendedSortByBundlesWeight` | an entity type's bundle field | `entity_type.bundle.info` bundle labels |
| `extended_sort_by_user_role_weight` | `ExtendedSortByUserRoleWeight` | the `user__roles` field | `user_role` entities (anonymous skipped; authenticated → NULL branch) |

All extend `ExtendedSortByWeightBase` (which extends core `views\Standard`). They **cannot be
exposed** to site visitors (`canExpose()` returns FALSE) — the weights are set by the view builder.

## How they appear in the Views UI

`views_sort_options_weight.views.inc` adds the handlers via `hook_views_data_alter` and
`hook_field_views_data_alter`:
- For each `list_string`/`list_float`/`list_integer` field it adds a
  `<field>__sort_options_weight` sort labelled "<Field> (set weight)".
- For an entity type's bundle key it adds `<bundle_key>__sort_bundles_weight` "(set weight)".
- For `user__roles.roles_target_id` it adds a `…__sort_options_weight` using the role handler.

So in *Views → Sort criteria → Add*, look for the "… (set weight)" variant of your field, bundle,
or roles field.

## The weight options form

`buildOptionsForm()` renders a required numeric box per value; `defineOptions()` seeds defaults as
sequential integers (first value → 1, second → 2, …). Lower weight sorts first. Combine with the
standard **sort order** (ASC/DESC) and add a secondary sort for tie-breaking.

## Generated SQL

`query()` (in the base class) emits an ordered CASE expression on the field column:

```sql
ORDER BY CASE
  WHEN <col> = '<value1>' THEN <weight1>
  WHEN <col> = '<value2>' THEN <weight2>
  ...
  WHEN <col> IS NULL THEN <weight_for_authenticated>   -- role handler only
  ELSE 1000
END
```

Any value without a configured weight (e.g. a legacy/removed allowed value) falls to `1000`, so
unmatched rows group at the end.

## Note for maintainers (not a runtime vulnerability)

`query()` interpolates the value keys and weights directly into the SQL string
(`"WHEN {$query_field_name} = '{$key}' THEN {$this->options[$key]} "`) rather than binding
placeholders. The interpolated `$key`s come only from **admin-defined config**: a field's
`allowed_values` keys, entity bundle machine names, or role machine names; the weights come from
the view's own sort options (set behind `administer views`). No request/URL/low-privilege data
reaches this expression, so it is not an injection vector as shipped — but a hardening patch would
still parameterize it, and the pattern is worth knowing before extending the handlers.
