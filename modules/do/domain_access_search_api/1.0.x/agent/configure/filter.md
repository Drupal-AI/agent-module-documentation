# The Views filter, index processor, and required fields

No settings page — everything is wired in the Search API index and the View.

## 1. Index the required fields

On the Search API index (`/admin/config/search/search-api/index/<id>/fields`) add:

- **`field_domain_access`** (type: string) — required; the filter matches against it.
- **`field_domain_all_affiliates`** (boolean) — required only if you enable the all-affiliates
  processor.

Without `field_domain_access` on the index the filter has nothing to match (README caveat).

## 2. (Optional) Enable the all-affiliates processor

On the index's *Processors* tab enable **"Apply domain access all affiliates to allowed domains
property"** (`domain_access_search_all_affiliates_processor`). At `preprocess_index`
(`DomainAccessIncludeAllAffiliatesProcessor::preprocessIndexItems`): for each item whose
indexed `field_domain_all_affiliates` first value is truthy, it replaces the item's
`field_domain_access` values with `array_keys(Domain::loadMultiple())` — i.e. every domain id —
so "all affiliates" content matches the current-domain filter on every domain. Reindex after
enabling.

## 3. Add the filter to a view

In a Search API index-based view, add filter **"Search API: Current domain"** (group *Domain*),
machine id `domain_access_search_api_current_all_filter`, exposed on the table as `current_all`.

- It is a `BooleanOperator` (`DomainAccessSearchApiCurrentAllFilter`); value options Yes/No,
  `operators()` returns `[]` (no operator selector).
- `query()`: gets the active domain from `\Drupal::service('domain.negotiator')->getActiveDomain()`;
  if a current domain exists and the filter value is non-empty, adds
  `->query->addWhere(group, field_domain_access, <current_domain_id>, '=')`.
- `getCacheContexts()` adds `url.site`, so results cache per domain.

Set the filter value to **Yes** (usually not exposed) to restrict the view to the current
domain. When value is empty/No it adds no condition (returns everything indexed).

## Important: this is a display filter, not enforced access control

The filter only narrows results *when it is added to a view and its value is truthy*. It does
not automatically enforce Domain Access on Search API queries the way node access grants do.
If a Search API view must not leak other domains' content, you (the site builder) must add this
filter (value Yes) to every such view; omitting it returns all indexed items regardless of
domain. Treat it as query scoping for site-building, not as a substitute for access control.
