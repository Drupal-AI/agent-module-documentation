<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity API, display plugin, hook & templates

## The entity

`\Drupal\search_api_page\Entity\SearchApiPage` (interface
`\Drupal\search_api_page\SearchApiPageInterface`) — a `ConfigEntityBase`. Load via storage
`search_api_page`. Useful getters:

| Method | Returns |
|---|---|
| `getPath()` | the URL path (no leading slash) |
| `getIndex()` | bound index machine id |
| `getCleanUrl()` | bool |
| `getLimit()` | pager size |
| `getSearchedFields()` | array of field ids to search |
| `getFulltextFields()` | `[field_id => label]` of the index's full-text fields (loads the Index) |
| `getStyle()` | `view_modes` \| `search_results` |
| `renderAsViewModes()` / `renderAsSnippets()` | bool style helpers |
| `showSearchForm()` | bool |
| `showAllResultsWhenNoSearchIsPerformed()` | bool |
| `getViewModeConfiguration()` | resolved view-mode config per datasource/bundle |
| `getParseMode()` | Search API parse mode id |

`calculateDependencies()` adds a `config` dependency on the bound index.
`postSave()`/`postDelete()` rebuild the router so the page's path route stays in sync.

## Search API display plugin

The module provides a Search API **Display** plugin `search_api_page`, derived per page
(`SearchApiPageDeriver`), plugin id `search_api_page:<page_id>`. This is what lets **Facets**
(and other display-aware code) attach to an individual search page. `isRenderedInCurrentRequest()`
matches when the current path contains the page's path. You do not instantiate this directly —
it is discovered from the existing `search_api_page` entities.

## Alter hook

```php
/**
 * @param array $build            Page render array.
 * @param \Drupal\search_api\Query\ResultSet $query_result
 * @param \Drupal\search_api_page\SearchApiPageInterface $search_api_page
 */
function hook_search_api_page_alter(&$build, $query_result, $search_api_page) {
  $build['#search_title'] = ['#markup' => t('@n results', ['@n' => $query_result->getResultCount()])];
}
```

Invoked by `SearchApiPageController` after running the query — use it to add/adjust page
elements (title, help text, extra render children) using the full `ResultSet`.

## Theming

Two theme hooks (override in your theme):

- `search_api_page` — the results page. Variables: `form`, `search_title`, `no_of_results`,
  `no_results_found`, `search_help`, `results`, `pager`. Template `search-api-page.html.twig`.
- `search_api_page_result` — one result row (used by the `search_results` snippet style).
  Variables: `item`, `entity` (+ preprocessed `snippet`, `title`, `url`, `info`, `info_split`).
  Template `search-api-page-result.html.twig`.
