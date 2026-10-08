<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Facets widget that shows a facet's values as form checkboxes inside a Facets Form and puts a type-to-filter searchbox above the list.

---

Facets Form Searchbox Widget is a small display-layer add-on for the Facets and Facets Form modules. It registers one widget plugin, "Searchable Checkboxes (inside form)" (`facets_form_searchable_checkbox`), that you pick when editing a facet that is rendered through a Facets Form. The widget extends Facets Form's checkbox widget, so the facet's values become real form checkboxes that submit with the form, and it adds a client-side searchbox above them: as the visitor types (two characters or more), the JavaScript filters the checkbox rows to those whose label contains the typed text, shows a "No results found." message when nothing matches, and keeps any already-checked rows visible. A configurable JavaScript "soft limit" collapses long lists behind "Show more" / "Show less" links so only the first N values show until the visitor expands them. All filtering is done in the browser against the values already on the page; the module adds no routes, permissions, settings page, or config of its own, and it never changes which results a visitor is allowed to see — result access still follows the underlying search index. It requires both `facets` and `facets_form` and works on Drupal 9.2, 10, and 11.

---

- Make a Facets Form facet with a long list of checkbox values searchable with a type-to-filter box.
- Turn a scroll-heavy checkbox facet (hundreds of terms, tags, or authors) into a quickly filterable list.
- Present facet values as form checkboxes that submit together with a Facets Form rather than instant-apply links.
- Add find-as-you-type filtering within a single facet without writing custom JavaScript.
- Collapse a long facet list behind a "Show more" link using the widget's JavaScript soft limit.
- Let visitors expand and re-collapse the hidden facet values with "Show more" / "Show less" controls.
- Keep already-selected (checked) facet values visible even when the soft limit or filter would otherwise hide them.
- Show a "No results found." message when a visitor's search text matches none of the facet values.
- Configure how many values are shown before collapsing by setting the per-widget "Soft limit" (0, 3, 5, 10, 15, 20, 30, 40, or 50).
- Improve the usability of taxonomy, tag, brand, or location facets that have many possible values.
- Provide an accessible searchbox (labelled input with `aria-labelledby`) for filtering a facet's checkboxes.
- Reuse Facets' existing indexing and result counts while changing only how the facet is displayed.
- Filter facet labels case-insensitively as the visitor types, matching any substring of the label.
- Keep facet result counts visible next to each value while still allowing search filtering.
- Style the searchable facet list with the module's bundled CSS (`css/searchable-facets.css`).
- Offer a form-based faceted-search UI on sites that submit filters instead of applying them on click.
- Disable the widget by switching the facet back to a standard Facets widget; no data migration is needed.
- Support Drupal 9.2, 10, and 11 sites that already run Facets and Facets Form.
- Combine the searchbox with hierarchical (indented) facet values, which the checkbox widget still renders.
- Reduce visual clutter on filter sidebars that expose several large facets at once.
