Maps an external API response to a filterable, sortable local listing using dot-notation field mapping and an SDC display, without writing custom render code.

---

The Mirror submodule turns an API Orchestrator endpoint's response into a browsable data table. An `api_mirror` config entity references an endpoint, a dot-notation `root_path` to the array of items in the response, a `remote_id_path`, and a set of field mappings (source path → display column, type, sortable/visible/weight) and filter mappings (text/exact/range). Data is fetched live from the API on each page load: `JsonPathResolver` flattens the response and resolves paths (supporting `[]` iteration and `[N]` indexing), and `MirrorQueryService` applies filtering, sorting and pagination in PHP before returning JSON to an SDC listing component rendered with AJAX. A sample-fetch endpoint flattens a live response so you can discover available paths while configuring mappings. Requires `api_orchestrator`.

---

- Display an external API's records (products, posts, orders) as a sortable Drupal admin table.
- Map deeply nested JSON fields to columns using dot-notation paths (`data.products.edges[].node.title`).
- Point a mirror at a GraphQL or REST endpoint already defined in API Orchestrator.
- Discover available response paths with the built-in sample-fetch/flatten tool while configuring.
- Mark columns sortable, visible, and ordered by weight.
- Add text-contains, exact-match and numeric-range filters to the listing.
- Paginate results with a configurable items-per-page.
- Fetch data live on every view (no local storage/sync required in the current live mode).
- Show a single-object response as a one-row listing automatically.
- Set a remote ID path to identify each item uniquely.
- Use it with the JSONPlaceholder, Shopify or Magento sample integrations out of the box.
