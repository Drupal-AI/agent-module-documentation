<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Centarro Search provides a Search API backend that indexes and queries content through Elastic Enterprise Search (Elastic App Search).

---

Centarro Search (from Centarro, the Drupal Commerce company) ships a single Search API backend plugin,
`centarro_search_ees` (`ElasticEnterpriseSearchBackend`), that connects Drupal's Search API to an Elastic
Enterprise Search 8.x deployment. Indexing, schema updates, and document deletion go through the Elastic
**App Search** API using the official `elastic/enterprise-search` PHP client; queries are executed against an
App Search **engine** you name per index. It translates Search API queries into App Search search requests —
mapping conditions to filters, ranges, and negations, and Search API facets (including OR-operator facets via
extra queries) to App Search facets. Booleans are indexed as integers and timestamps as ISO-8601 dates because
App Search does not accept those types natively. Configure an "Elastic Enterprise Search (Centarro Search)"
Search API server with the App Search host and API key, then set the engine name in each index's third-party
settings. It requires the Search API module and suggests Facets. Content and search queries are sent to the
external Elastic endpoint; only index and expose data your search audience is permitted to see, and treat the
App Search API key as a secret.

---

- Add Elastic Enterprise Search (Elastic App Search) as a Search API backend for a Drupal site.
- Power Drupal Commerce product and category search with Elastic's business tooling.
- Index nodes, commerce products, or any Search API datasource into an App Search engine.
- Query an existing App Search engine by name from a Search API index.
- Run multiple indices, each mapped to its own App Search engine.
- Expose search as a View built on the Search API index (use Direct query parse mode for fulltext filters).
- Add faceted search over Elastic-indexed content, including OR-operator (multi-select) facets.
- Apply range filters on date, integer, and decimal fields (from/to bounds).
- Support negation filters (`<>`, `NOT IN`, `NOT BETWEEN`) mapped to App Search "none" filter groups.
- Sort results by indexed fields or by relevance (`_score`).
- Auto-create an App Search engine when an index is updated if one does not already exist.
- Push Search API field definitions to App Search as an engine schema (text/number/date mappings).
- Reindex automatically when an index's field set changes.
- Delete individual documents or clear an entire engine (paged list-then-delete) from Drupal.
- Let business users manage synonyms, curations, and relevance tuning in Elastic's UI while Drupal serves results.
- Review search analytics and top/no-result keywords in Elastic while running the storefront in Drupal.
- Translate Search API language filtering into an App Search `search_api_language` filter.
- Restrict indexed content to chosen datasources and fields via Search API's index configuration.
- Store the App Search host and API key on the Search API server as backend configuration.
