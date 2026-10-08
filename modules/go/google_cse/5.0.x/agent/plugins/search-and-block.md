<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# google_cse — search plugin & block

The module **consumes** two plugin types; it defines none of its own.

## Search page plugin `google_cse_search`

`src/Plugin/Search/GoogleSearch.php` — a core `ConfigurableSearchPluginBase` implementing
`AccessibleInterface`.

- Plugin id `google_cse_search`, title "Google Programmable Search" (declared via both the
  `@SearchPlugin` annotation and the `#[Search(...)]` attribute).
- Instantiated as a **core Search page** (`search.page.<id>` config entity). See
  [../configure/search-page.md](../configure/search-page.md) for every `configuration.*` key.
- `defaultConfiguration()` seeds `cx`, `results_display` (`here`|`google`),
  `custom_results_display`, `display_drupal_search`, `results_accessibility`, `watermark`,
  `query_key` (default `keys`), `results_searchbox_width` (40), `results_prefix`,
  `results_suffix`, `custom_css`, `data_attributes` (`[]`).
- `access()` returns allowed only for accounts with the **`search Google CSE`** permission.
- The module dynamically rewrites the search page's route controller
  (`RouteSubscriber::alterRoutes`) to `GoogleCseSearchController::view`, and
  `hook_entity_insert` rebuilds routes whenever a `google_cse_search` search page is saved.
- Rendering: results are produced by Google's embedded JavaScript element, not by Drupal.
  `hook_preprocess_item_list__search_results()` suppresses Drupal's "no results" list so
  the Google widget owns the results area.

**No Drupal index / cron / Search API** — Google hosts the index. Live results require a
real Programmable Search Engine (`cx`) and the browser executing Google's script.

## Block `google_cse`

`src/Plugin/Block/GoogleSearchBlock.php` — core `@Block` id `google_cse`, admin label
"Google Programmable Search", category "Forms". A combined **search box + results** widget
you place in any region (`/admin/structure/block`) for pages that should not use a
standalone `/search/...` route. Google's help text warns: do **not** place this block on
the search page itself, or the results fail to display.

## Core search block redirect

When a `google_cse_search` page is the **default** search, the module's
`hook_form_alter` (`google_cse_form_search_block_form_alter`) restyles the core search
block; if `results_display` is `google` it sets the form action to
`https://cse.google.com/cse` and injects the `cx` as a hidden `cx` field so a submit goes
straight to Google's hosted results page.
