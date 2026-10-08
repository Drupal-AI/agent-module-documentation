<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Teaches Views Filters Summary how to render Commerce's entity-bundle exposed filter.

---

This submodule implements `hook_views_filters_summary_plugin_alias()` to alias Commerce's `commerce_entity_bundle` filter plugin to the built-in `bundle` handling, so selected product/entity bundle values are resolved to their bundle labels in the summary. Requires Drupal Commerce.

---

- Show selected Commerce product-type (bundle) values in a filters summary.
- Resolve commerce_entity_bundle filter values to bundle labels.
- Build a storefront results summary from Commerce exposed filters.
- Display active product-category facets on a Commerce product listing view.
- Enhance the Views Exposed Filters Summary area so it displays this module's filter type correctly.
- Enable it alongside the parent views_filters_summary area on a header/footer of a view.
- Keep the active-filters summary readable when using this companion module.
- Add per-value remove links to the summary for the supported filter type.
- Combine with the summary's reset-all link for a full faceted-results bar.
- Show a 'Displaying N results for ...' line that understands this filter type.
- Group multi-value selections of the supported filter under one label.
- Avoid writing your own alter-hook glue to support this filter in the summary.
- Turn raw filter ids/values into human-readable labels in the summary.
- Drop it in as an optional submodule only when you use the companion module.
- Enhance the Views Exposed Filters Summary area so it displays this module's filter type correctly.
- Enable it alongside the parent views_filters_summary area on a header/footer of a view.
