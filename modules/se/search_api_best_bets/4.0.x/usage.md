Search API Best Bets lets editors attach "best bets" to entities: per-entity search keywords that elevate that entity to the top of Search API results (or exclude it) when a user searches for those words. It ships a Solr query handler and a pluggable handler system for other backends.

---

Editors configure best bets through a custom field type `search_api_best_bets` added to entity bundles. Its widget (`search_api_best_bets_widget`) shows two comma/newline-separated textareas — "elevate" queries and "exclude" queries — stored as rows of `query_text` (lowercased) + an `exclude` flag. Access to the field is gated by `hook_entity_field_access`: viewing/editing the field requires the `view search_api_best_bets keywords` / `edit search_api_best_bets keywords` permissions. The search side is a Search API processor plugin (`search_api_best_bets_processor`, "Search API Best Bets") enabled and configured on a Search API index's Processors tab: you pick which best-bets field(s) per datasource to use, choose a query-handler plugin, choose whether the elevated flag comes from the backend or is set locally, and optionally override the relevance score of elevated items. At query time the processor lowercases the search keys, runs an entity query to find entities whose best-bets `query_text` equals the keys (respecting `access('view')`), and hands the matched item ids to the query handler's `alterQuery()`. The bundled Solr handler (`solr`, for backends `search_api_solr` / `acquia_search`) translates those into Solr `elevateIds` / `excludeIds` parameters (with `forceElevation`/`enableElevation`) and reads the `[elevated]` flag back in `alterResults()`. The module defines a `search_api_best_bets_query_handler` plugin type (attribute + manager) so other modules can add handlers for non-Solr backends. Theming hooks add a `search-api-elevated` class (and an `elevated` variable) to elevated rows in Search API Pages results and Views rows. Note: matching is exact-equality on the whole (trimmed, lowercased) search string, and only simple/scalar query keys are handled.

---

- Promote a specific page to the top of search results for chosen keywords (editorial "best bets").
- Exclude a specific entity from results for chosen queries.
- Let content editors manage promoted results per node without touching Solr config.
- Add best-bets support to any entity bundle by adding the `search_api_best_bets` field.
- Elevate results in Apache Solr using native `elevateIds` / `excludeIds` parameters.
- Support Acquia Search (the Solr handler declares the `acquia_search` backend too).
- Override the relevance score of elevated items so they sort first by relevance.
- Choose whether the "elevated" flag is read from the backend or computed locally in Drupal.
- Style elevated search results distinctly via the `search-api-elevated` CSS class.
- Highlight elevated rows in Views built on a Search API index.
- Highlight elevated results in Search API Pages result templates.
- Restrict who can view or edit best-bets keywords via dedicated permissions.
- Configure multiple best-bets fields across different entity types on one index.
- Provide curated answers for high-value or ambiguous search terms.
- Boost seasonal/campaign landing pages for specific queries temporarily.
- Implement a query handler for a non-Solr Search API backend via the plugin type.
- Separate "elevate" and "exclude" query lists per entity in one widget.
- Localize best bets — the processor loads the context translation of each matched entity.
- Disable the "exclude" feature per field where the backend does not support exclusion.
- Keep best-bets logic query-time only (no elevate.xml generation required).
