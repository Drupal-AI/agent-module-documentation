Views Selective Filters adds a "selective" variant of every filterable Views field, so an exposed filter only offers the option values that actually appear in the current result set — no dead options that would return zero rows.

---

The module registers no config UI of its own. Instead, `hook_views_data_alter()` walks all Views data and, for every field that has a filter handler, adds a second synthetic field `<field>_selective` whose filter uses the plugin `views_selective_filters_filter` (class `Selective`). That plugin is a **proxy**: it wraps the original filter handler (kept as `proxy` in the handler definition) but overrides `getValueOptions()` to run a copy of the view and collect the distinct values present, then limits the exposed options to that set. In the view UI you add the field you want to filter on (optionally "Hidden from display"), then add the matching "… (selective)" filter and expose it; the filter and field must share the same base field or you get a mismatch error. Options include a display field to source labels from (`selective_display_field`), a sort mode for the options (`selective_display_sort`: ASC/DESC/KASC/KDESC/NONE/ORIG), aggregated fields, a target entity type, and a safety `selective_items_limit` (default 100) above which the field is rejected as unsuitable. Because it re-runs the query to gather values it is best on low-cardinality fields. Config for a placed filter is validated by the schema `views.filter.views_selective_filters_filter`.

---

- Show only the taxonomy terms that actually tag results in an exposed "Category" filter.
- Hide brand/manufacturer options that have no matching products in a catalog view.
- Offer only the content types present in a listing's result set in an exposed type filter.
- Keep an exposed "Author" filter limited to authors who wrote the listed content.
- Prevent users from selecting a filter value that returns an empty page.
- Trim a year/date-bucket exposed filter to years that have content.
- Build faceted-style exposed filters without a full facets stack.
- Limit an exposed "Status" or "State" filter to values in use.
- Reduce confusion in large filters by dropping never-matching options.
- Populate a select filter from distinct field values in the result set.
- Sort the offered options ascending/descending or by key (ksort) via the sort option.
- Keep the original filter's option order with the "As the original filter" (ORIG) sort.
- Source human-readable option labels from a chosen display field.
- Cap option generation with `selective_items_limit` to avoid huge selects.
- Combine a hidden display field with a selective exposed filter for clean output.
- Make a location/region exposed filter show only regions with results.
- Provide an exposed filter for an entity-reference field limited to referenced entities.
- Improve UX of a search/listing page where many filter values are irrelevant.
- Constrain an exposed filter on a product attribute to in-stock values.
- Avoid manually maintaining allowed-values lists for exposed filters.
