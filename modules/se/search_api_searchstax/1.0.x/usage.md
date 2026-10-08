<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API SearchStax adds a Solr *connector* plugin to `search_api_solr` so a Drupal site can index to and query a SearchStax-hosted Solr cloud using SearchStax's token-based authentication instead of running or securing its own Solr.

---

This module is not a standalone Search API backend. It is a single `SolrConnector` plugin (`id: searchstax`, "SearchStax Cloud with Token Auth") that extends `search_api_solr`'s `StandardSolrConnector`, so `search_api_solr` (and transitively `search_api`) must be installed. You still create a normal Search API server of type "Solr", but you pick the SearchStax connector on it. Configuration is deliberately minimal: instead of host/port/path/core fields you paste two values from your SearchStax dashboard — the **Update endpoint** URL and the **Read & Write token key**. The connector regex-parses the endpoint (`https://<host>/<context>/<core>/(update|select)`) to derive host, context and core, forces `scheme=https` and `port=443`, and on every connection sets an HTTP `Authorization: Token <token>` header on the Solr endpoint (Solarium's `setAuthorizationToken('Token', …)`). That token is the credential; it is stored as a plaintext string inside the Solr server's exported configuration, so it belongs in an environment variable / Key-style workflow rather than committed config, exactly as this repo's conventions require. Because SearchStax blocks several admin-only Solr APIs, the connector stubs them out: it hardcodes the reported Solr version (8.11.1 / `drupal-0.0.0-solr-8.x`), returns empty/placeholder data for Luke, core REST field-type introspection and stats, disables core reload, and generates the config-set (schema/solrconfig) locally with SolrCloud-appropriate tweaks. Practical caveats belong with any hosted-search choice: indexed content leaves the site and lives on SearchStax's infrastructure (a data-processing consideration for restricted/unpublished content, where Search API's own access handling is what governs who can query what), and managed Solr carries cost and some lock-in versus self-hosting Solr with `search_api_solr` directly.

---

- Add Solr-backed Search API without operating your own Solr server.
- Connect Drupal to a SearchStax-hosted Solr cloud index.
- Authenticate to SearchStax using its Read & Write token (HTTP `Authorization: Token`).
- Configure a Solr server by pasting just the Update endpoint URL and token.
- Let the connector derive host/context/core from the endpoint automatically.
- Force HTTPS (scheme `https`, port 443) for all SearchStax traffic.
- Reuse the full `search_api_solr` feature set (facets, languages, relevance, spellcheck).
- Generate and download the Solr config-set locally when SearchStax blocks server-side APIs.
- Work around SearchStax-blocked admin APIs (Luke, core REST, version detection) with safe stubs.
- Target a hardcoded Solr 8.11.1 baseline so modern field types are used, not the 6.0 fallback.
- Run SolrCloud-tuned commit settings and implicit request handlers via `alterConfigFiles`.
- Index and query content on cron like any other Search API Solr server.
- Keep the SearchStax token out of version control by sourcing it from an env var / Key.
- Ping the SearchStax core to verify connectivity (`pingServer` delegates to `pingCore`).
- Avoid running `search_api_solr_nlp` alongside it (declared Composer conflict).
- Requires `drupal/search_api_solr` ^4.2.1 and `solarium/solarium` ^6.2.7.
- Runs on Drupal core `^8.9 || ^9.3 || ^10.2 || ^11.0`.
- Provides no routes, permissions, services, or block/field plugins of its own — only the connector.
- Consider whether self-hosted Solr via `search_api_solr` is a better fit before committing to a paid managed backend.
- Remember indexed content is copied to SearchStax; verify Search API access handling for restricted content.
