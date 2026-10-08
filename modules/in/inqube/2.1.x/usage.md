Inqube lets a Drupal View run against an Elasticsearch index (via elasticsearch_helper) with the query body produced by a pluggable, site-provided query-builder class.

---

Inqube ("Index query builder for Elasticsearch") is a developer/base module that wires Views to the elasticsearch_helper Elasticsearch client. It registers a Views query plugin (`elasticsearch_query`, "Elasticsearch Query") that delegates building the actual query DSL to an `ElasticsearchQueryBuilder` plugin you write for your index. It also exposes a synthetic `elasticsearch_result` Views base table with field handlers that read values out of a hit's `_source`, render a matched Drupal entity in a view mode, convert source values into links, and an entity relationship that hydrates result rows into real entities. There is no admin UI, no routes, no permissions and no configuration schema — the module is meant to be extended in custom module code. To use it you add a builder plugin, create a View on the "Elasticsearch result" base table, pick your builder in the query settings, and add Inqube field/relationship handlers to shape output.

---

- Build a search results page backed by Elasticsearch instead of the SQL database, driven by a normal Drupal View.
- Reuse Views' pager, exposed filters, arguments and sort UI on top of an Elasticsearch index.
- Write a custom `ElasticsearchQueryBuilder` plugin that turns a view's filters/arguments/sorts into an Elasticsearch DSL query.
- Start from `BaseRootQueryBuilder` to build per-"root" sub-queries combined with a `bool.should` operator.
- Start from `BaseIndexRootQueryBuilder` when each root maps to a language-suffixed index (`{root}_index_{langcode}`).
- Use the trivial `default` builder as a placeholder while scaffolding a view (returns an empty query body).
- Map Views exposed filters to Elasticsearch `must`, `should`, `range`, or `query_string` clauses via `$shouldFilters`, `$mustFilters`, `$rangeFilters`, `$keywordFilters`.
- Implement a keyword/full-text search box that expands each term into `keyword OR keyword* OR *keyword*` across configured `$keywordFields`.
- Provide faceted-style range filtering (e.g. price/age buckets) by defining `$rangeFilters` with a ranges provider class.
- Sort results by URL query parameters (`?sort_by=...&sort_order=asc|desc`) mapped through the builder's `$sortFields` allowlist.
- Fall back to relevance (`_score`) sorting automatically when a keyword filter is active.
- Render each Elasticsearch hit's stored fields on the page using the "Source field" handler (`elasticsearch_source`) with dot-notation for nested `_source` keys.
- Use the "Inqube source field" handler to load a numeric source value as an entity label, optionally linked, or to convert a value into a link.
- Use the "Inqube source link" handler to render `_source` link fields (`{uri, title}`, single or multi-valued) as trimmed links.
- Render a full Drupal entity teaser/card from a search hit with the "Rendered entity" handler, choosing the view mode per entity-type:bundle in YAML.
- Hydrate search hits into real Drupal entities via the entity relationship by pointing it at the `_source` keys that hold the entity type and entity id.
- Show matched nodes/media/users with their real display and correct entity view-access checks, rather than raw index data.
- Combine multiple indices/bundles in one result set by returning several roots from a builder and letting Inqube `should`-combine them.
- Debug the generated Elasticsearch query in the browser console on AJAX views (for users with "administer views" when Views' "Show the SQL query" setting is on).
- Add or alter Inqube Views fields/filters for the `elasticsearch_result` table from your own module via `hook_views_data_alter()`.
- Expose aggregations by reading `$view->data` after execution (the raw Elasticsearch response is stored on the view).
