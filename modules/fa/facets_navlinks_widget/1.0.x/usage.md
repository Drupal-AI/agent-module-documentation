<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Facets widget that renders a facet's results as a list of real navigation links (with an optional reset link), instead of the toggle-style "List of links" widget.

---

Facets Navigation Links Widget is a small display add-on for the Facets module (`drupal/facets ^3.0`). It registers one facet widget plugin, `navlinks` ("List of navigation links", `src/Plugin/facets/widget/NavLinksWidget.php`), which extends Facets' `WidgetPluginBase`. Where the core "List of links" widget treats every link as a toggle — clicking the active facet link removes it — this widget keeps the active item as an ordinary, followable link (its `build()` re-adds the active facet's own filter to the link's query so it stays selected) and wraps the whole list in a `<nav>` element for cleaner, more accessible, SEO-friendly navigation. The widget adds three configuration options on each facet's edit form: "Show reset link", the "Reset text" shown for that reset link (default "Show all"), and "Hide reset link when no facet item is selected". Rendering is handled by two Twig templates the module ships (`facets-item-list-navlinks.html.twig` and `facets-result-item-navlinks.html.twig`) plus `hook_theme()`/`hook_preprocess` in the `.module`, which delegates to Facets' own `facets_preprocess_facets_item_list()`. The module has no routes, permissions, forms, services, config objects, config schema, entities or Drush of its own — it is purely a per-facet display choice configured through the standard Facets admin UI.

---

- Present a facet (e.g. category, brand, content type, tag) as a set of navigation links rather than checkboxes or a dropdown.
- Keep the currently active facet value rendered as a real, clickable link instead of a toggle that clears itself.
- Build SEO-friendly faceted navigation where each facet value is a normal followable link/URL.
- Improve screen-reader accessibility of facet navigation by wrapping the list in a `<nav>` element.
- Add a "Show all" reset link at the top of a facet so visitors can clear that facet's selection in one click.
- Rename the reset link text per facet (e.g. "All categories", "Reset", "View all") via the "Reset text" option.
- Hide the reset link until a value is actually selected, using "Hide reset link when no facet item is selected".
- Show the reset link as active/current when no value in that facet is selected (default state).
- Replace the core "List of links" widget on an existing facet without changing the underlying Search API index or facet source.
- Use facet values as top-level menu or sidebar navigation in a themed region.
- Drive category landing-page style navigation from a Search API + Facets setup.
- Preserve other active facet filters and the current query string when following or resetting a link.
- Return to the first result page automatically when a visitor clicks the reset link.
- Style facet navigation with the widget's stable hooks: the `facets-navlink` element class and the `facets-reset` wrapper class on the reset item.
- Theme the markup by overriding `facets-item-list-navlinks.html.twig` (the `<nav>`/`<ul>` wrapper) or `facets-result-item-navlinks.html.twig` (per-item value and count).
- Optionally display each value's result count next to its link (Facets' "Show count" behavior, via `show_count`).
- Offer faceted browsing that degrades gracefully as plain links for crawlers and no-JS clients.
- Provide consistent, link-based facet navigation across multiple facets on the same page.
- Combine with any Facets-supported facet source (Search API views, search pages, etc.).
- Migrate a facet from toggle-style links to navigation links purely as a widget/config change.
