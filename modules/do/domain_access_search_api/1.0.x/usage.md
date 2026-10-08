Domain Access Search API bridges the Domain Access module to Search API: it adds a Views filter that restricts a Search API index-based view to items available on the current domain, plus an index processor that expands "all affiliates" content to every domain.

---

Domain Access ships a "Current domain" Views filter, but that filter only works against the SQL entity storage, not against Search API index tables. This module re-implements it for Search API. Via `hook_views_data_alter()` (`DomainAccessSearchApiHooks::viewsDataAlter`) it registers, on every `search_api_index_<id>` Views table, a `current_all` boolean filter (`domain_access_search_api_current_all_filter`) under the "Domain" group, mapped to the indexed `field_domain_access` field; it also removes the stale `relationship` on the domain-access field (domains aren't stored in the DB). The filter (`DomainAccessSearchApiCurrentAllFilter`, extends `BooleanOperator`) adds `WHERE field_domain_access = <current domain id>` using `domain.negotiator`'s active domain when the filter value is truthy, and adds the `url.site` cache context. A companion Search API processor, `domain_access_search_all_affiliates_processor` ("Apply domain access all affiliates to allowed domains property"), runs at `preprocess_index` and, for any item whose indexed `field_domain_all_affiliates` is TRUE, overwrites its indexed `field_domain_access` values with the ids of *all* domains — so "send to all affiliates" content matches the current-domain filter everywhere. Requires the Domain Access field (`field_domain_access`, string) — and, for the processor, `field_domain_all_affiliates` — to be added to the Search API index. It has no config UI, permissions, schema, or Drush; the filter is opt-in per view and is a display/query filter, not an enforced access-control layer.

---

- Restrict a Search API-backed view to nodes published to the current domain.
- Reproduce Domain Access's "Current domain" filter for Solr/Database Search API indexes.
- Build per-domain search result pages on a multi-domain (affiliate) site.
- Include "all affiliates" content in every domain's search results via the index processor.
- Add a "Domain → Search API: Current domain" exposed or non-exposed filter to a faceted search view.
- Keep a shared Search API index while showing domain-appropriate results per site.
- Ensure content flagged for all affiliates surfaces on each domain's search without duplicating it.
- Filter a global site-search index down to the visitor's current domain automatically.
- Vary cached search results by domain using the filter's `url.site` cache context.
- Power a multi-tenant catalog search where each tenant sees only its domain's items.
- Combine with Search API facets to scope facets to the current domain.
- Provide domain-scoped autocomplete/search blocks on affiliate sites.
- Migrate an existing Domain Access SQL view to a Search API index while keeping domain filtering.
- Show cross-domain "all affiliates" announcements in every site's search listing.
- Limit an events or news search view to the domain the user is browsing.
- Avoid leaking other domains' content into a shared index-based search view (when the filter is applied).
- Support Domain 2.x and 3.x on Drupal 10.1+/11 with Search API 1.38+.
- Index `field_domain_access` (+ `field_domain_all_affiliates`) once and reuse across per-domain views.
- Group the domain filter under the Views "Domain" group for editors to find easily.
- Rescope a single view per domain without cloning the view for each site.
