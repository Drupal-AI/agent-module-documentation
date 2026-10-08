# Year Views — `year_field` Views filter

`YearField` (`@ViewsFilter("year_field")`) extends `Drupal\views\Plugin\views\filter\ManyToOne`, so
it inherits multi-value select behaviour and the "is one of / is not one of" operators.

## Options (`defineOptions`)
- `year_from` — default `-30 years`
- `year_to` — default `+15 years`
- `sort_order` — default `asc`

`hasExtraOptions()` returns TRUE; `buildExtraOptionsForm()` exposes:
- **From year** / **To year** — required textfields accepting a specific year (e.g. `1965`, `2055`)
  or a relative expression (`now`, `-20 years`).
- **Sort order** — radios `asc` / `desc`.

## Option list generation (`init`)
On init the plugin builds `valueOptions` = `range(calculateYear(year_from), calculateYear(year_to))`
combined into a `value => value` array, reversed when `sort_order == 'desc'`.
`calculateYear($year)` resolves a non-numeric value via `date('Y', strtotime($year))`.
`getValueOptions()` returns this list for the exposed dropdown.

## Wiring
Set a `year` field's Views filter handler to `year_field` (via the field's `hook_views_data` /
Views data). Then add it as an exposed filter on the View to present the dropdown.
