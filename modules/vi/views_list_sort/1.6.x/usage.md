Views List Sort lets a View sort results by a **List (text)** field's *allowed-values order* — the order the options are defined in the field settings — instead of alphabetically, so a `low/medium/high` field sorts in that sequence rather than `high/low/medium`.

---

The module provides a single Views **sort handler**, `sort_allowed_values`
(`Drupal\views_list_sort\Plugin\views\sort\SortAllowedValues`). Via
`hook_field_views_data_alter()` it swaps the default sort plugin for every `list_string` field's
`_value` column to this handler, so the extra options appear automatically when you add that field
as a sort criterion in a View. The handler adds two option checkboxes: **"Sort by allowed values"**
(`allowed_values`) which, when on, orders rows by the index of each stored key within the field's
`options_allowed_values()` list using a SQL `FIELD(column, key1, key2, …)` expression; and **"Treat
null values as heavier than the allowed values"** (`null_heavy`) which reverses the FIELD ordering
(multiplying by -1) so empty/unknown values sort last. When "Sort by allowed values" is off the
handler behaves like a normal sort. It adds no config schema file of its own but registers the two
option keys on `views.sort.*` schemas through `hook_config_schema_info_alter()`. There is no admin
settings page — everything is configured per-View on the sort criterion.

---

- Sort a "priority" list field (`low`/`medium`/`high`) in defined order, not alphabetically.
- Order content by a "status" list field (`draft`/`review`/`published`) in workflow sequence.
- Present a "t-shirt size" listing as `S`, `M`, `L`, `XL` rather than `L`, `M`, `S`, `XL`.
- Sort event sessions by a "difficulty" list (`beginner`/`intermediate`/`advanced`).
- Keep a "day of week" list field in Mon→Sun order in a schedule View.
- Order a product View by a "tier" field in the sequence the tiers were defined.
- Push rows with an empty list value to the end using the null-heavy option.
- Reverse-rank so unset values sort as the heaviest/last entries.
- Sort a directory by a "membership level" list in ascending defined order.
- Order a support-ticket View by "severity" in its intended (non-alphabetical) order.
- Display survey responses grouped by a Likert-scale list field in scale order.
- Sort catalog items by a "condition" list (`new`/`refurbished`/`used`).
- Keep a "phase" taxonomy-like list field in project-phase order in reports.
- Order a jobs board by "seniority" list values in the defined progression.
- Sort recipes by "spice level" list in ascending heat order.
- Combine with other View sorts as a primary custom-order criterion.
- Avoid re-keying allowed values just to get the display order right.
- Sort admin content listings by a custom-status list field meaningfully.
- Order a resource library by "reading level" list values.
- Present a pricing table sorted by a "plan" list in package order.
- Sort by allowed values ascending or descending via the sort order plus null-heavy toggle.
