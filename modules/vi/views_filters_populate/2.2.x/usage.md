<!-- SPDX-License-Identifier: GPL-2.0+ -->
Views Filters Populate lets one Views filter (typically an exposed one) copy its submitted value into one or more other, non-exposed filters, so a single input effectively searches across multiple fields at once.

---

The module ships a single Views filter plugin, `views_filters_populate` (class `Populate`), which does not filter anything itself. Instead, when its value is set — either as a static value or, more commonly, as the value a site visitor types into an exposed filter — its `preQuery()` copies that value onto the `value` property of every target filter listed in its `filters` option, provided the targets are non-exposed `StringFilter` or `NumericFilter` handlers in the same display. Those targets then run their own normal query logic (e.g. "contains" on a string field, "=" on a numeric field) using the populated value, so multiple otherwise-independent filters end up searching for the same term. If the populate filter is itself exposed and the visitor submits it empty, an internal mock handler (`PopulateRemoveEmptyFilterMock`) removes both the populate filter and all its listed targets from the view for that request, so the whole group behaves as an optional exposed filter instead of matching "empty string" on every target. The plugin's `validate()` also checks, at view-save/build time, that every listed target filter still exists and is not itself exposed. There is no settings form, permission, or Drush command — the only administrative surface is the "Available filters" multi-select added to the populate filter's own Views UI configuration form, and the only persistent state is the `filters` array stored on that filter handler inside the view's configuration.

---

- Let one exposed search box match a node title, a body field, and a custom text field simultaneously.
- Provide a single "keyword" filter that searches across several taxonomy-reference label filters at once.
- Combine a numeric "min price" filter across two different price fields stored on different field tables.
- Simplify an exposed filter UI so editors see one text box instead of five separate ones.
- Make an "instant search" exposed filter populate hidden filters on title, subtitle, and summary fields.
- Search a product SKU and a legacy SKU field together from one exposed input.
- Populate a hidden numeric filter on `field_min_price` and another on `field_sale_price` from one exposed slider.
- Let a single "author name" exposed filter populate both a first-name and last-name string filter.
- Avoid duplicating exposed filter widgets when several fields should respond to the same typed value.
- Reduce the number of query parameters end users need to fill in on a search view.
- Drive several non-exposed contextual filters' equivalents (filters, not arguments) from one exposed control.
- Build a "search everywhere" filter across a multi-field content model without custom PHP.
- Keep a filter optional (no WHERE clause added) automatically when the exposed populate value is left blank.
- Populate identical values into a set of translated/duplicate fields kept in sync across languages.
- Feed one exposed numeric filter's value into multiple numeric fields representing different measurement units.
- Simplify a "search this listing" box on a view that otherwise needs an OR filter group across many fields.
- Populate hidden filters from a value submitted via a custom exposed form alter, without rebuilding the query manually.
- Let a REST/JSON:API-adjacent Views display accept one query parameter that maps to several backing filters.
- Provide one filter in the Views UI that a site builder can wire to newly added filters later, just by editing `filters`.
- Populate a non-exposed numeric filter and a non-exposed string filter from the same populate value at once.
- Use a single "quick filter" exposed text field to narrow a table view by multiple columns' filters together.
- Avoid maintaining duplicate exposed widgets when a filter group's targets change over time.
- Populate targets across relationships as long as each target is still a non-exposed String/Numeric filter handler.
- Keep an admin-facing report view's exposed filter simple while still filtering several underlying fields.
- Drop a filter and its targets from the query entirely when the exposed populate value is empty, instead of matching blanks.
- Chain the populate filter with Views filter groups (OR) so the populated targets combine with `OR` logic.
