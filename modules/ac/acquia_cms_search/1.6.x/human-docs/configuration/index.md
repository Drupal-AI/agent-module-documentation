# Configuration

Acquia CMS Search ships a working search configuration, so most of the "setup" is
really about making sure its **Search API index has a server to run on** and then
building that index. Everything here happens under **Configuration → Search and
metadata**.

## 1. Make sure a Search API server exists

The shipped configuration references a search index, and that index needs a
**server** backing it.

- Go to **Configuration → Search and metadata → Search API**
  (`/admin/config/search/search-api`).
- In the full distribution the index runs on **Solr**; on a lighter setup you can
  use Search API's **database** backend (`search_api_db`), which is included as a
  dependency.
- Confirm the index is attached to a server and shows as enabled. If the module
  failed to enable, it is almost always because this server/index was missing —
  create the server, attach the index, then re-enable the module.

## 2. Index your content

- On the index's page, run **Index now** (or let cron index over time) to populate
  it with your Acquia CMS content types.
- Check the index status shows items indexed; search returns nothing until this
  has run.

## 3. Review the facets

- Go to **Configuration → Search and metadata → Facets**.
- The module ships facet definitions (for example content type and other fields).
  Enable, reorder, or adjust them to match how you want visitors to narrow
  results. Facets Pretty Paths gives the facet URLs clean, readable paths.

## 4. Place the search block (if needed)

The search results page is provided as a View. If you also want a search box in a
region, place the search block through **Structure → Block layout**, and place the
facet blocks near the results.

## Verify it works

Visit the search results page on the front end, run a query, and confirm results
appear and the facets filter them. If results are empty, re-check that the index
has actually been built (step 2) and that its server is reachable.
