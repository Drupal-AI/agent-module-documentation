Hides specific nodes from Drupal core's node search results by node ID, without unpublishing them or changing access.

---

The module provides one admin form at `admin/config/search/search_exclude_nid` (permission `administer search
exclude nid`) where an admin enters a comma-separated list of node IDs. On save, each value is cast to an int,
verified to reference an existing node, de-duplicated, and the resulting list is stored in **State** under
`search_exclude_nid.excluded_nids` (not config). At search time it implements
`hook_query_search_node_search_alter()` and adds a `n.nid NOT IN (:excluded)` condition to the core node-search
query, so excluded nodes never appear in standard search results. It only affects core Search's `node_search`
query — it does not touch Search API, Views, or entity access, and the nodes remain fully viewable by direct
URL. An `update_9001` hook migrates any old config-based list into State storage.

---

- Hide a specific node from core search results by its node ID.
- Exclude several nodes at once with a comma-separated NID list.
- Keep a landing page reachable by URL but out of the search index results.
- Remove an outdated article from search without unpublishing it.
- Exclude utility/system nodes (thank-you pages, redirects) from search.
- Suppress duplicate/near-duplicate nodes from search listings.
- Validate entered NIDs against existing nodes on save (bad/duplicate IDs are dropped with a warning).
- Manage the exclusion list from a single admin form.
- Exclude nodes from search results without writing custom query alters.
- Hide gated or campaign nodes from organic search discovery.
- Temporarily pull a node from search by adding its NID, then restore it by removing it.
- Store the exclusion list in State so it is not part of exported configuration.
- Apply exclusions globally to core node search for all users.
- Keep excluded nodes' access and visibility unchanged (search-only filtering).
- Grant the exclusion admin capability to a specific role via one permission.
