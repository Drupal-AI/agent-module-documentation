A submodule of Choices.js that adds a `choices_js` Facets widget, rendering a facet's options as a Choices-powered select dropdown.

---

`choices_facets` bridges the [Facets](https://www.drupal.org/project/facets) module and Choices.js. It provides a single Facets widget plugin (`ChoicesWidget`, id `choices_js`) that builds a `select` render element from the facet's results — each result becomes an option whose value is the facet result URL, with active results pre-selected and optional result counts appended (respecting the facet's *show numbers* and *show only one result* settings). The select is marked with `js-facets-choices`/`js-facets-widget` classes and `data-drupal-facet-id`, and attaches the `choices_facets/widget` library (which depends on `facets/widget` and `choices/choices`). The bundled `js/choices-widget.js` initialises Choices on the element and hooks it into the Facets JS API so selecting an option navigates to the facet URL. Choose the widget in a facet's configuration under *Search > Facets*; it has no config entities or settings of its own beyond the standard Facets widget options.

---

- Render a Facets facet as a searchable Choices dropdown instead of a checkbox/link list.
- Provide a single-select facet dropdown when the facet is set to "show only one result".
- Provide a multi-select facet dropdown when multiple results are allowed.
- Show result counts next to each facet option (Facets "show numbers" setting).
- Give a large taxonomy facet a type-to-filter dropdown UI.
- Replace the default Facets HTML widgets with a consistent Choices look across a search page.
- Let visitors clear/deselect a facet value via the Choices remove button (when configured).
- Pre-select the currently active facet values in the dropdown.
- Use Choices facets alongside Search API / facets result pages.
- Keep facet styling consistent with Choices field widgets elsewhere on the site.
- Offer a compact facet UI where screen space is limited.
- Improve keyboard/accessibility handling of long facet option lists.
- Drive facet navigation via option selection (URL from `$result->getUrl()`).
- Hide or show the facet title via the facet's "show title" setting.
- Combine with the parent Choices global/CDN library settings for a single library source.
