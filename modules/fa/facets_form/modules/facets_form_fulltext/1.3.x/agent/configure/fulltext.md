<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fulltext widget & query type

## Widget — `facets_form_fulltext` (`FulltextWidget`, final)
Extends Facets `ArrayWidget`, implements `FacetsFormWidgetInterface`, uses `FacetsFormWidgetTrait`.
Set it as the Widget on a (fulltext) facet to expose it in the facets form.

### Config (`facet.widget.config.facets_form_fulltext`)
- `label` — field label (default "Search").
- `placeholder` — input placeholder (default "Type a word").
- `operator` — `=` (Equals; match the whole phrase) or `AND` (each whitespace-separated word must
  match; order-independent). Default `=`.

### `build()`
Renders a single `#type => textfield` with the configured label + placeholder, pre-filled from the
facet's active item. Sets a fake empty `Result` so the widget stays visible under Facets' empty
behavior. Cache contexts `url.query_args`, `url.path`. `prepareValueForUrl()` returns the trimmed
search string (or `[]` if empty). `getQueryType()` = `facets_form_fulltext`.

## Value object — `Fulltext` (`src/Fulltext.php`, final)
Wraps the searched text; `setSearch()` trims input; `isEmpty()` true when blank;
`createFromFacet()` reads the facet's first active item; `__toString()` returns the search.

## Query type — `facets_form_fulltext_query_type` (`FulltextQueryType`, final)
Registered onto core Facets by `facets_form_fulltext.module`
(`hook_facets_search_api_query_type_mapping_alter`). `execute()`:
- operator `AND` → `createConditionGroup('AND')`, split the search on `\s+`
  (`PREG_SPLIT_NO_EMPTY`), add one condition per word on the facet's field identifier, add the group.
- otherwise → one `addCondition(fieldIdentifier, search, operator)` for the whole phrase.

`build()` yields the summary `Result` "Contains @search". (Filtering is delegated entirely to
Search API's query condition layer.)
