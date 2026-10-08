<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hosted Solr provides a Search API Solr connector plugin tailored to the Hosted Solr managed service. It preconfigures the HTTPS scheme, port 443, and basic-auth credentials so administrators only paste the host and the user/password shown in their Hosted Solr account.

---

The `HostedSolrConnector` plugin extends `SolrConnectorPluginBase` (from `search_api_solr`) and uses `BasicAuthTrait` for HTTP basic authentication. Its `defaultConfiguration()` forces `scheme = https` and `port = 443`; the configuration form hides scheme/port/path and derives the Solr path from the username on submit. The Solarium HTTP client is created with a short request timeout. Ping and server-info operations delegate to core-plugin core-level equivalents.

This is a search backend connector. It has no end-user-facing routes or permissions of its own; it is configured through the Search API server form (which requires Search API admin permissions). Security notes: the connection is pinned to HTTPS with no option to disable TLS, and credentials are the standard Search API server basic-auth values stored in the server config entity.

---

- Connect a Search API server to the Hosted Solr service.
- Index Drupal content into a Hosted Solr core.
- Force HTTPS (scheme https, port 443) for the connection.
- Authenticate with Hosted Solr user/password via basic auth.
- Paste just the host value from the Hosted Solr dashboard.
- Derive the Solr path automatically from the username.
- Provide faceted, full-text search via Search API Solr.
- Use Solarium under the hood for Solr communication.
- Avoid running or maintaining a local Solr server.
- Ping the Solr core to verify connectivity.
- Retrieve Solr core/server info.
- Apply a bounded request timeout to Solr calls.
- Reuse all Search API Solr indexing and query features.
- Configure entirely through the Search API server form.
- Keep TLS always on (no plaintext option).
- Store credentials in the Search API server config entity.
