# Reference implementation

This submodule is the framework's worked example. Read it next to the parent's
[../../../../2.2.x/agent/api/framework.md] and [../../../../2.2.x/agent/api/facets.md].

## Routes (`elasticsearch_search_api_example.routing.yml`)

| Route | Path | Controller method | Access |
|---|---|---|---|
| `elasticsearch_search_api_example.search` | `/example/search` | `ExampleSearchController::search` | `_permission: access content` |
| `elasticsearch_search_api_example.filter` | `/example/search/filter` | `ExampleSearchController::filter` | `_permission: access content` |
| `elasticsearch_search_api_example.autocomplete` | `/example/search/autocomplete` | `ExampleSearchController::handleAutocomplete` | `_permission: access content`, `_format: json` |

## Services (`elasticsearch_search_api_example.services.yml`)

Concrete instances of the framework services, keyed to the `example_general` index:
- `elasticsearch_search_api_example.elasticsearch_params_builder` → `ExampleElasticSearchParamsBuilder`
- `elasticsearch_search_api_example.elasticsearch_result_parser` → `ExampleElasticSearchResultParser`
- `elasticsearch_search_api_example.search_repository` / `.search_action_factory` /
  `.elasticsearch_indexfactory_adapter` / `.factory.index` (index `example_general`)
- `elasticsearch_search_api.facet_control.page_type` → `PageTypeFacetControl` (the facet, keyed by id)
- `elasticsearch_search_api.term_facet_storage` / `.term_tree_storage`,
  `elasticsearch_search_api.suggest.title_suggester`
- parameters: `elasticsearch_search_api_example.index = 'example_general'`,
  `elasticsearch_search_api.search_page_size = 10`, `…ngram_min/max = 6`.

## Classes

- `Controller\ExampleSearchController` — extends the base `SearchController`; overrides `create()` to inject
  the `*_example.*` services, `getFacets()` → `['page_type']`, `getSearchHeader()` (renders the parent
  `SearchForm` with inline autocomplete + AJAX), and `getSearchUrl()`/`getFilterUrl()` → the example routes.
- `Search\ExampleElasticSearchParamsBuilder` — extends the base params builder; builds a
  `function_score` + `multi_match` (`most_fields`) query over all Search API fulltext fields with per-field
  boosts, adds `.ngram` sub-field queries (default boost `0.1`), a `cross_fields` boost for multi-word
  queries, `phrase` matches for quoted phrases (via `UtilityHelper::extractQuotedString()`), and ES result
  `highlight` (`<strong>` tags, fragment size 300).
- `Search\ExampleElasticSearchResultParser` — extends the base parser; keeps the raw hit rows (not just
  ids) so highlight fragments are available, and parses facet aggregation buckets.
- `Search\PageTypeFacetControl` — extends `TermFacetBase` for the `page_type` vocabulary/property path;
  hierarchical, multi-select, term-weight sorted, added to aggregations; renders top-level terms + children.
- `Search\Suggest\ExampleTitleSuggester` — an ES phrase-suggester on `title` (same shape as the parent's
  `TitleSuggester`).

## Installed config (`config/install/`)

- `node.type.elasticsearch_page`, `field.storage.node.field_page_type` + `field.field.*`,
  `field.field.node.elasticsearch_page.body`, entity form/view displays.
- `taxonomy.vocabulary.page_type`.
- `search_api.index.example_general` — datasource `entity:node` (bundle `elasticsearch_page`), server
  `elastic`; fields `title` (string), `body` (text, boost 5), `nid`, `page_type` (integer, term id),
  `page_type_name` (text, boost 8); `index_directly: true`, `cron_limit: 50`.

## Anomalies

- `services.yml` declares `elasticsearch_search_api_example.snippet_builder` →
  `Drupal\elasticsearch_search_api_example\SnippetBuilder`, but **no `SnippetBuilder.php` ships** in 2.2.1 —
  a stale reference (unused by the routed controllers).
- `services.yml` passes 4 constructor args to
  `elasticsearch_search_api_example.event_subscriber.initialize_index`
  (`InitializeIndexEventSubscriber`), whose class constructor accepts **one** (`Index`); the extra
  parameters are ignored/stale. Treat this submodule as a scaffold to adapt, not copy verbatim.
