<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# esa_pager — agent index

Submodule of **elasticsearch_search_api**. A custom "large" pager for Elasticsearch - Search API result
pages: a Views pager plugin plus a themeable, AJAX-friendly pager template (first/prev/numbered/ellipsis/
next). Core `^10.2 || ^11`. Its `.info.yml` declares no dependencies (uses core Views + core pager); pair
it with the parent's search pages.

- **The `esa_pager` Views pager plugin + `esa_pager` theme/preprocess + pager library** →
  [views/pager.md](views/pager.md)

Key facts:
- Views pager plugin id `esa_pager` (`src/Plugin/views/pager/EsaPager.php`, extends `views…pager\SqlBase`,
  `theme = "esa_pager"`, `register_theme = FALSE`).
- Theme hook `esa_pager` (`esa_pager_theme()`), template `templates/esa_pager.html.twig`, preprocess
  `esa_pager_preprocess_esa_pager()`.
- Library `esa_pager/pager` (`css/esa_pager.css`), attached by the preprocess.
- The parent's `SearchController::renderPager()` renders `#theme 'esa_pager'` directly (with `#tags`,
  `#total_items`, `#items_per_page`, `#route_name`, `#route_params`), so the pager also works outside Views.
- Adds the `url.query_args` cache context.
- No routes, permissions, services, config schema, or drush commands.
