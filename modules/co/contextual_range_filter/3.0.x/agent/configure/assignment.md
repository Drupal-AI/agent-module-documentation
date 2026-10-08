# Convert a contextual filter into a range filter

There is no per-handler checkbox in the Views UI (Views picks the handler class before you could
choose a range variant). Instead you first add a **normal** contextual filter to your View, then
convert it on the settings page.

## Steps

1. In the Views UI, Advanced → **Contextual filters** → add the field/property as usual, save.
2. Go to `/admin/config/content/contextual-range-filter` (route
   `contextual_range_filter.settings`, form `ContextualRangeFilterAssignmentForm`, permission
   `administer contextual range filters`).
3. The page lists every contextual filter found across all Views, grouped into **date**,
   **numeric** and **string** sections (classification is by the handler's base class: `Date` →
   date, `StringArgument` → string, everything else → numeric; lists count as numeric).
4. Tick the filters to convert and **Save configuration** (caches are cleared — may take a while).

## What saving does

For each ticked/unticked filter the submit handler:

- writes the selected machine names into `contextual_range_filter.settings` under
  `numeric_field_names`, `string_field_names` or `date_field_names` (each a list of
  `table:field`, e.g. `node__field_price:field_price_value`); and
- rewrites the argument's `plugin_id` on the affected View display(s): to `numeric_range` /
  `string_range` / `date_range` when converting on, or back to the core `numeric` / `string` /
  `date` when converting off; then calls `drupal_flush_all_caches()`.

So the persistent state is **two** things: the settings config list AND the View's argument
`plugin_id`.

## Inspect / set from drush

```bash
# Which filters have been converted?
drush cget contextual_range_filter.settings

# Inspect a View's argument plugin id (the *_range plugins are the converted ones)
drush cget views.view.<view_id> display.default.display_options.arguments
```

```php
// Read the converted numeric filters
$converted = \Drupal::config('contextual_range_filter.settings')->get('numeric_field_names');
```

## URL range syntax (all inclusive)

| URL argument | Meaning |
|---|---|
| `100--199.99` | from 100 to 199.99 (BETWEEN) |
| `100--` | from 100 upward (>=) |
| `--149.95` | up to 149.95 (<=) |
| `100` | single exact value |
| `k--q` | alphabetic range k…q (string_range, case-insensitive) |
| `2020-01-01--2020-06-30` | date range (date_range) |
| `a--e+k--r` | a–e OR k–r (needs "Allow multiple ranges") |
| `all` / `--` / `:` | return all results for this filter position |

`:` may be used instead of `--`. Tick **Exclude** on the filter's *More* section to negate
(NOT BETWEEN / `<` / `>`).
