Custom View Filters adds three ready-made Views filter handlers — an A‑Z (first-letter) filter, a year/month "granular date" filter, and a since/until date-range picker — that you drop onto a node View without writing any code.

---

The module implements `hook_views_data_alter()` to register three filter handlers against the `node_field_data` table under the Views group **"Custom View Filters"**: `custom_az_filter` (exposed as the Views field `custom_az_filter`), `node_granular_date_filter` (field `nodes_granular_dates`), and `date_range_picker_filter` (field `date_range_picker`). Each handler extends core's `FilterPluginBase`. You add the filter to a View like any other filter and, in its settings, type the **machine name of the field** it should act on (there is no field autodetection — you enter e.g. `field_fullname`, `field_build_date`, or a supported special property). The A‑Z filter matches the first letter of the first or second word of a text field (or the special `title`); the granular date and range filters operate on a date field's `_value` column, or the special `created`/`changed` node timestamps. Every filter works either as an **admin (non-exposed)** filter with a fixed value chosen in the View UI, or as an **exposed** filter the visitor controls. Because each exposed control is a real form element keyed by the filter's exposed identifier, you can print it directly in a Views template with `{{ form.custom_az_filter }}`, `{{ form.nodes_granular_dates }}`, etc. The module has no settings form, no `configure` route, no permissions, and no config schema of its own — all state lives inside the View config entity's filter handler options.

---

- Add an alphabetical A‑Z pager to a staff or member directory View, filtering by the first letter of a name field.
- Let visitors jump to surnames by filtering on the first letter of the **second** word of a full-name field.
- Filter an events View by year and month using a date field, exposed as two dropdowns.
- Provide a "since / until" date-range picker on a news or articles View.
- Filter nodes by creation month across all years (e.g. everything created in December).
- Filter content by the `created` or `changed` node timestamp without adding a date field.
- Build a glossary/index page where each letter narrows a text field.
- Add an admin-only (non-exposed) A‑Z constraint to a View to hard-scope a block listing.
- Restrict a "publications" View to a single year chosen by the site builder.
- Expose a date-range filter and render it in a custom Twig template with `{{ form.date_range_picker }}`.
- Offer single-letter or multi-letter (checkbox) A‑Z selection via the exposed "Allow multiple selections" option.
- Filter a catalog View by the first letter of a product-title-like text field.
- Add a year-only filter (leave month "All") to a yearly archive View.
- Add a month-only filter (leave year "All") to show seasonal content across years.
- Combine the granular date filter with other exposed filters on the same View.
- Present a birthday/anniversary listing filtered by month of a date field.
- Filter a jobs board by posting date range on a custom `field_posted` date field.
- Scope a members block to names beginning with a specific letter set by an editor.
- Provide alphabetical navigation for a taxonomy-driven listing built on nodes.
- Filter archived content between two picked dates for an admin cleanup View.
- Customize the A‑Z filter's selectable year range (`granular_year_from` / `granular_year_until`) for the date filter.
- Render the exposed filter inline in a template instead of the default Views exposed form block.
- Add whole-alphabet quick links above a long content listing.
- Filter event nodes to a specific month/year for a printable calendar-style page.
