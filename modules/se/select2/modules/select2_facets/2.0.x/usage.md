Select2 Facets adds a searchable Select2 widget to the Facets module, so faceted-search filters render as a Select2 dropdown instead of a plain checkbox/link list.

---

Select2 Facets is a submodule of Select2 that registers a `select2` Facets widget (`FacetsWidget` plugin). On any facet you can pick the Select2 widget and its results become a searchable, optionally multi-select Select2 box built from the facet's result URLs (each option's value is the facet result URL; active results are pre-selected). It reuses the parent module's `#type => 'select2'` render element, so it inherits placeholder, clear, i18n and theming behaviour, and honours the facet's "show only one result" (single vs multiple) and "show numbers" settings. The widget can also **autocomplete** facet values over AJAX via its own `select2_facets.facet_autocomplete` route (controller rebuilds the facet against the request path and returns matching results as JSON), which is useful for facets with very many values. Configuration (width, autocomplete on/off, match operator) lives on the facet's widget config form, schema-backed by `facet.widget.config.select2`. It depends on the Facets module and the Select2 main module. A small `select2-widget.js` behaviour submits the facet form on change.

---

- Turn a facet block into a searchable Select2 dropdown instead of a checkbox list.
- Let users multi-select several facet values from one Select2 box.
- Restrict a facet to single-select by enabling the facet's "show only one result".
- Show result counts next to each facet value in the Select2 options.
- Autocomplete facet values over AJAX for facets that have thousands of values.
- Choose "Starts with" or "Contains" matching for facet autocomplete.
- Give editors a compact filter UI for search pages with many facets.
- Set a fixed width for the facet's Select2 widget (px, %, em, or `element`).
- Reuse Select2 theming/i18n on faceted search filters automatically.
- Pre-select the currently active facet values in the dropdown.
- Auto-submit the facet form when a value is chosen (no separate apply button).
- Replace a long, scroll-heavy facet list with a type-to-find control.
- Combine with Search API + Facets for a modern exposed-filter experience.
- Clear a single-value facet selection with the Select2 clear button.
- Deploy the facet widget config (width, autocomplete, match operator) between environments.
- Keep facet UI consistent with Select2 select/reference widgets used elsewhere on the site.
- Use on views-page or search-page facet sources exposed through Facets.
