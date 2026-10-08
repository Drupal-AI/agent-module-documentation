<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Esa Pager is a submodule of elasticsearch_search_api that provides a custom "large" pager — a Views pager plugin plus a themeable, AJAX-friendly pager template — for Elasticsearch - Search API result pages.

---

Esa Pager adds a Views pager plugin (`esa_pager`, extending the core SQL full pager) and an `esa_pager` theme hook whose preprocess builds first/previous/numbered/ellipsis/next items from Drupal's pager manager, with `data-page` attributes for AJAX paging and a `url.query_args` cache context. The parent module's `SearchController::renderPager()` renders this theme directly, so the pager works both as a Views pager and on the framework's custom search pages. It ships no routes, permissions, services, config schema, or drush commands — only the plugin, theme, template, and a small CSS library.

---
- Add a large numbered pager to an Elasticsearch search results page.
- Choose "Custom Esa pager" as the pager on a View.
- Render first/previous/numbered/next links with ellipses.
- Support AJAX page changes via data-page attributes.
- Override the pager markup with a Twig template.
- Show an accessible pager with visually-hidden labels.
- Page through large Elasticsearch result sets.
- Reuse the parent's SearchController pager rendering.
- Keep query-string arguments across page links.
- Style the pager via the esa_pager/pager CSS library.
- Add a center window of page numbers around the current page.
- Paginate a Search API view with a custom pager.
- Provide previous/next navigation on a search page.
- Enable alongside the parent search framework.
- Keep it disabled when a custom pager is not needed.
