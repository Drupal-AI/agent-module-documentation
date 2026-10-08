# Enabling selective options (Views UI)

No settings form. Configure per exposed filter inside a view:

1. Edit the view → **Exposed form** format is **Better Exposed Filters** (Settings).
2. In BEF settings, pick the widget for the filter (Default select / Links / Checkboxes /
   Radio buttons).
3. New checkboxes appear (only for supported filter types — see below):

- **Show only used items** — restrict the exposed values to those present in the result set.
- **Filter items based on filtered result set by other applied filters** — recompute options
  from the set already narrowed by *other* exposed filters (cascading/faceted behavior).
  Does not work when the view uses an AJAX exposed form in a block.
- **Hide filter, if no options** — set the element `#access = FALSE` when only "- Any -"
  (or nothing) would remain.
- **Show option items count** — append `(N)` to each option instead of hiding unused ones.

The last three only show when **Show only used items** is checked (`#states`).

## Supported filter types
Taxonomy term (`TaxonomyIndexTid`), Entity reference, Bundle, List/Options field, VERF,
Search API options. **Not** supported: "Has taxonomy term" depth
(`TaxonomyIndexTidDepth`). The filter must be exposed.

## Stored config
The options are saved into the view's BEF filter config as `options_show_only_used`,
`options_show_only_used_filtered`, `options_hide_when_empty`, `options_show_items_count`
(schema added via `hook_config_schema_info_alter` onto
`better_exposed_filters.filter.{default,bef_links,bef}`).
