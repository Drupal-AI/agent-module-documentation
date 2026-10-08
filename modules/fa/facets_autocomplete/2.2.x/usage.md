<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets autocomplete adds a single Facets widget, `autocomplete`, that renders a facet as a type-ahead text field instead of a long checkbox or link list, so a facet with hundreds of values becomes a searchable box.

---

Facets normally draws each facet as a list — checkboxes, links, or a dropdown — which stops scaling once the value set is large; a "manufacturer" or "author" facet with hundreds of entries becomes taller than the results it filters. This module supplies a facet widget plugin, `AutoCompleteWidget` (id `autocomplete`, "Textfield with autocomplete"), chosen per facet in the Facets UI. Its `build()` method takes the results Facets has already computed for the facet (so they still honour the facet source and search index, including that index's access filtering — the widget does not re-query) and passes every value plus its facet URL into `drupalSettings`; the bundled `js/autocomplete-widget.js` then filters that list by prefix, case-insensitively, entirely in the browser, and selecting a suggestion navigates to that value's facet URL. There is no server route, controller, or AJAX endpoint — only a widget and an asset library. Settings (schema `facet.widget.config.autocomplete`) cover an optional reset link (`show_reset_link`, `reset_text`, `hide_reset_when_no_selection`), the placeholder (`default_option_label`), and the inherited `show_numbers`. Because it is a widget, switching a facet to or from it is a one-setting change with no re-index, and it spans Facets `^2.0 || ^3.0` on core `^9.2 || ^10 || ^11`.

---

- Make a facet with hundreds of values usable.
- Replace a long checkbox list with a type-ahead field.
- Let visitors search within a single facet instead of scrolling it.
- Filter a product catalogue by manufacturer via autocomplete.
- Shorten a facet block on a results page.
- Improve faceted search on mobile.
- Keep a facet's definition, source, and index unchanged while changing only its UI.
- Offer autocomplete on an author or contributor facet.
- Give a library catalogue a subject/keyword filter box.
- Handle a location facet with many entries.
- Switch a facet's widget without re-indexing content.
- Combine autocomplete facets with checkbox facets on the same page.
- Add a reset link that clears the active facet filter.
- Show result counts beside each suggestion (`show_numbers`).
- Set placeholder text prompting the visitor to start typing.
- Improve discoverability in a large taxonomy-backed facet.
- Reduce the vertical footprint of a filter panel.
- Let power users jump straight to a known value and its facet URL.
- Support a site running either Facets 2.x or 3.x.
- Restyle the type-ahead dropdown to match a theme via its CSS classes.
