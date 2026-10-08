# Theme hooks, libraries, view mode & other hooks

## Theme hooks (`hook_theme` in the .module)

All ship with a Twig template in `templates/` and are used by `SearchController`/`SearchForm`.

| Theme hook | Template | Key variables |
|---|---|---|
| `elasticsearch_search_api_search` | elasticsearch-search-api-search.html.twig | header, facets, active_filters, results, result_count, breadcrumbs, did_you_mean |
| `elasticsearch_search_api_error` | …-error.html.twig | error_message |
| `elasticsearch_search_api_facets` | …-facets.html.twig | facets |
| `elasticsearch_search_api_facets_item_list` | …-facets-item-list.html.twig | items, title, list_type, wrapper_attributes, attributes, empty, context |
| `elasticsearch_search_api_facets_result_item` | …-facets-result-item.html.twig | value, show_count, count, is_active, for, has_children, children |
| `elasticsearch_search_api_result_count` | …-result-count.html.twig | result_count |
| `elasticsearch_search_api_autocomplete` | …-autocomplete.html.twig | results, layout_wide |
| `elasticsearch_search_api_suggestions` | …-suggestions.html.twig | did_you_mean_label, suggestions |

`elasticsearch_search_api_preprocess_elasticsearch_search_api_facets_item_list()` delegates to core
`template_preprocess_item_list()`. The pager theme (`esa_pager`) is provided by the `esa_pager` submodule.

## Libraries (`elasticsearch_search_api.libraries.yml`)

| Library | Assets / deps |
|---|---|
| `styles` | `css/elasticsearch_search_api.css` |
| `ajaxify` | `js/search-ajaxify.js` (core jquery, drupal.ajax, drupalSettings, once) — drives the `filter` AJAX callback |
| `inline-autocomplete` | `js/search-inline-autocomplete.js` — calls the autocomplete endpoint from a search form |
| `loading-overlay` | `/libraries/jquery-loading-overlay/src/loadingoverlay.js` — the `gasparesganga/jquery-loading-overlay` external library (a composer `suggest`, needed for AJAX search) |

## Other hooks / install behavior

- `hook_install` + `hook_ENTITY_TYPE_insert` (`elasticsearch_search_api_node_type_insert`) call
  `Utility\UtilityHelper::configureSearchIndexViewMode()`, which creates and enables a **`search_index`
  view mode** on every node type (existing ones on install, new ones on creation), stripping all display
  components except `title`. Run a config export afterwards to persist it. Skipped during config sync.
- `hook_search_api_items_indexed` invalidates the `elasticsearch_search_api.search` cache tag.
- `Utility\UtilityHelper::extractQuotedString(&$keyword)` pulls `"quoted phrases"` out of a keyword string
  (used by the example params builder for phrase matching).
