<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Range Input adds a min/max range-input widget (and companion processor) to the Facets module so visitors filter a numeric facet by entering a lower and upper bound.

---

Facets Range Input extends the Facets module with a range-input widget and a matching processor for numeric facets. Instead of ticking discrete facet values, the visitor sees two HTML5 number fields — a minimum and a maximum — and an Apply button; submitting them filters the search results to that range. The widget (plugin `range_input`, `RangeInputWidget`) renders a small AJAX form (`RangeInputForm`) with configurable field titles and placeholders, and declares the Facets query type `range` so the actual filtering is handled by the Facets range query type. The companion processor (plugin `range_input`, `RangeInputProcessor`) builds the range URLs, parses the submitted bounds back out (numeric-only), and synthesises the intermediate step results. It depends only on the Facets module and works with any Facets source (typically a Search API index). It is a pure search-UI feature: it shapes how a facet is presented and queried, not access — results still respect the underlying index and entity access. You enable it per facet by choosing the range-input widget on that facet's edit form; there is no site-wide settings page.

---

- Let visitors filter a numeric facet by a min/max range instead of discrete values.
- Add a range-input facet widget to a Search API faceted search.
- Filter a product listing by price range (e.g. between 20 and 80).
- Filter content by a numeric rating range.
- Filter by any indexed numeric field using lower and upper bounds.
- Provide two number inputs plus an Apply button as the facet UI.
- Configure the minimum and maximum field titles per facet.
- Configure the minimum and maximum field placeholders per facet.
- Apply the range filter over AJAX without a full page reload.
- Delegate the range filtering to the Facets `range` query type.
- Show the currently active min/max back in the inputs after filtering.
- Generate intermediate step results between the discovered min and max.
- Restrict submitted bounds to numeric values before they reach the query.
- Combine a range facet with other active facets on the same search.
- Improve faceted-search UX where a list of individual values is impractical.
- Style the range form via the module's `css/range-input.css` layout library.
- Override the `facets-range-input.html.twig` / `facets-range-input-form.html.twig` templates in a theme.
- Reuse the widget across multiple facets and multiple search pages.
- Enable range filtering without writing any custom JavaScript.
- Present a "between X and Y" filter for admin-defined numeric facets.
