# Faceted search

Facets are added by registering a service per facet, named by the convention
`elasticsearch_search_api.facet_control.<facet-machine-name>`, and by adding the facet's machine name to
the controller's `getFacets()`. Params builder, result parser, action factory and the controller all
resolve the control by `\Drupal::service('elasticsearch_search_api.facet_control.' . $facet)`.

## Facet control interfaces (`src/Search/Facet/Control/`)

- `FacetControlInterface` — a flat facet. Key methods: `getFieldName()` (the ES field to aggregate/filter),
  `addToAggregations(): bool`, `build($facet, $searchAction, $result): array` (render array).
- `CompositeFacetControlInterface extends FacetControlInterface` — for facets whose stored value maps to a
  composite (e.g. hierarchical) value: adds `buildFacetValuesFromQuery($query, $facet)`,
  `buildFacetFilter($selectedValues)`, `parseResult($counts)`.
- `TermFacetBase` (abstract) — base for taxonomy-term facets. Configure in your subclass constructor with
  `setVocabulary()`, `setfacetValuesSortMethod()` (`SORT_TERM_WEIGHT`), `setCanSelectMultiple()`,
  `setEnableHierarchy()`, `setIncludeEmptyFacets()`. Implement `getFieldName()`, `addToAggregations()`,
  `getFacetTitle()`, and `build()`/`buildChildren()`. It renders via `buildFacetsFromTerms()`. Constructor
  wants a `FacetValueMetaDataTreeStorageInterface`, the route name, and `entity_type.manager`. See the
  example's `PageTypeFacetControl` for a full hierarchical implementation.

## Facet value objects (`src/Search/Facet/`)

- `FacetValueInterface` / `FlatFacetValue` — a single selected value (`value()`).
- `HierarchicalFacetValue` (`HierarchicalFacetValueInterface`) — a value plus its ancestor chain
  (`ancestors()`, `parent()`); built by `SearchActionFactory::getHierarchicalValues()` using
  `taxonomy_term` storage `loadAllParents()`.
- `CompositeFacetValue`, `ChildOf`, `Without` — composite-filter helpers (unit-tested in `tests/`).
- `FacetCollection`, `FacetValuesCollection` — immutable collections (`with()`/`without()`/`has()`/
  `values()`/`isEmpty()`), keyed by facet id.
- `FacetValueMetaData` + `FacetValueMetaData{,Tree}StorageInterface`, `TermFacetValueMetaDataStorage`,
  `TermFacetValueMetaDataTreeStorage` — load term metadata (label, weight, children) for facet display.
  Registered in the example as `elasticsearch_search_api.term_facet_storage` / `.term_tree_storage`.

## How facets become an ES query (`ElasticSearchParamsBuilder`)

- `buildAggregations()` — for each available facet whose `addToAggregations()` is TRUE, adds a `terms`
  aggregation on `getFieldName()` (size 999); if other facets are already chosen it wraps it in a
  `filter` sub-aggregation so counts reflect the other active filters.
- `buildFacetFilters()` — for chosen values, builds `term` filters (multiple values → `bool.should`),
  applied as the query `post_filter` so facet counts stay complete while results are filtered.

## Active filters (`src/Search/FacetedSearchActiveFiltersBuilder.php`)

`build(FacetedSearchAction): ?array` renders the "chosen filters" chips: one link per selected value
(and hierarchical ancestors) that points at the search route with that value removed, plus a
"remove all" link. Uses `SearchQueryBuilder::buildFacetedQuery()` to build the URLs and the metadata
storage for labels. (Some default chip labels/titles are hard-coded Dutch strings.)

## Search-action model (`src/Search/`)

`FacetedSearchAction` (implements `FacetedSearchActionInterface`) is an immutable value object:
`getSize()`, `getFrom()`, `from()`, `getAvailableFacets()`, `getChosenFacetValues()`,
`with/withoutFacet(Value)()`, `hasMorePages()`, `nextFrom()`. `FacetedKeywordSearchAction` adds
`getKeyword()`.
