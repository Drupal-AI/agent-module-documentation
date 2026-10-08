<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vertex AI Search Recrawl asks Google Vertex AI Search (Discovery Engine) to recrawl a node's canonical URL whenever the node is created, updated or deleted, keeping a website data store's index fresh.
---
On `hook_node_insert/update/delete` (or the equivalent `hook_event_dispatcher` events when that contrib module is present), `NodeUpdateSubscriber::handleNode()` builds the node's absolute canonical URL, applies an optional node-type filter, and calls `VertexRecrawlService::recrawlUris()`. The service authenticates to Google using a service-account JSON key: it builds and RS256-signs a JWT (`openssl_sign`) and exchanges it at `https://oauth2.googleapis.com/token` (JWT-bearer grant) for an access token, then POSTs the URLs to the Discovery Engine `siteSearchEngine:recrawlUris` endpoint with a Bearer token. Deleting a node triggers a recrawl that returns 404, signalling Vertex to drop the page from its index.

All HTTP calls use Drupal's `http_client` (Guzzle) with default TLS verification against Google's HTTPS endpoints — no TLS is disabled. Importantly the service-account key is **not stored in Drupal config**: the settings form stores only a filesystem path to the JSON key (validated to exist, be readable, and contain `private_key`/`client_email`), and the key is read from disk at request time. Configuration (`/admin/config/search/vertex-search-recrawl`, `administer site configuration`) also captures GCP project id, data store id, location (default `global`), an enable toggle, and which node types trigger recrawls.

Setup: enable the Discovery Engine API and create a Website (Advanced) data store in Google Cloud, create a service account with the Discovery Engine Editor role and place its JSON key on the server (ideally under `private://` or a non-web path), then fill the settings form with project/data-store/location and the key file path and enable the module.

---

- Trigger a Google Vertex AI Search recrawl when a node is saved
- Reindex a page in Discovery Engine on node insert/update
- Remove a deleted node's URL from the Vertex index (via 404 recrawl)
- Restrict recrawls to selected node types
- Authenticate to Google with a service-account JSON key
- Sign a JWT and exchange it for an access token (jwt-bearer flow)
- POST canonical URLs to the siteSearchEngine:recrawlUris endpoint
- Configure GCP project id, data store id and location
- Store the service-account key as a file path, not in config
- Validate the key file exists, is readable and is a valid SA key
- Enable/disable recrawling with a master toggle
- Keep a Vertex website data store fresh automatically
- Use hook_event_dispatcher events when that module is present
- Fall back to core node hooks when hook_event_dispatcher is absent
- Log success/failure of each recrawl request
- Point the key at a private:// path outside the web root
