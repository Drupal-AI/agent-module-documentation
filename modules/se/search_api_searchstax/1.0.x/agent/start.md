<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API SearchStax (search_api_searchstax) — agent index

A single **Solr connector plugin** for `search_api_solr`, not a standalone backend. It lets a
Search API "Solr" server talk to a **SearchStax**-hosted Solr cloud using SearchStax token auth.

- **Plugin:** `SolrConnector` id `searchstax`, label "SearchStax Cloud with Token Auth",
  class `Drupal\search_api_searchstax\Plugin\SolrConnector\SearchStaxConnector` extending
  `StandardSolrConnector`.
- **Depends on** `search_api_solr` (^4.2.1) and `solarium/solarium` (^6.2.7); `search_api` is
  pulled in transitively. Core `^8.9 || ^9.3 || ^10.2 || ^11.0`.
- **Auth mechanism:** on `connect()` it sets `Authorization: Token <update_token>` on the Solr
  endpoint via Solarium `setAuthorizationToken('Token', …)`. Traffic is forced to HTTPS/443.
- **Config:** two fields on the connector form — `update_endpoint` (SearchStax "Update endpoint"
  URL) and `update_token` ("Read & Write token key"). The endpoint is regex-parsed into
  host/context/core. No dedicated config route; configured through the Search API server form.
- **No** routes, permissions, services, controllers, hooks, or Drush commands of its own.

## Files
- `agent/config/connector-setup.md` — how to create the server, the two form fields, endpoint
  parsing, and where the token is stored.
- `agent/api/connector-internals.md` — the overridden connector methods, the token-auth call, and
  the SearchStax-blocked-API stubs (version, Luke, REST, config-set generation).

## Operational notes for recommendations
- **Credentials are a live secret.** The `update_token` is stored as a plaintext string in the
  Solr server's exported config. Source it from an environment variable / Key workflow, not
  committed config.
- **Indexed content leaves the site** to SearchStax. For unpublished/restricted content that is a
  data-processing question, and **Search API's own access handling** decides who can query it —
  verify it rather than assuming the hosted backend enforces anything.
- **Cost and lock-in.** Managed Solr is billed; confirm self-hosted `search_api_solr` was ruled
  out on purpose.
- **Conflicts** with `search_api_solr_nlp` (Composer `conflict`).
