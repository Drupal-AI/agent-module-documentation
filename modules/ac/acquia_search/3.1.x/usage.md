<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Search connects a Drupal site to Acquia's hosted, managed Apache Solr service, plugging into Search API (via search_api_solr) as a pre-configured Solr server whose connection is authenticated with the site's Acquia subscription credentials.

---

Acquia Search is an integration layer, not a search engine of its own: it rides on top of **search_api_solr** and adds a Solr **connector** plugin (`solr_acquia_connector`) and a Search API **backend** (`acquia_search_solr`) that sign every request to Acquia's Solr endpoints with HMAC credentials derived from the **acquia_connector** subscription (identifier + secret key + application UUID). It ships a ready-made Search API server (`acquia_search_server`) and settings object (`acquia_search.settings`) so that, once the site is connected to an Acquia subscription, indexing and querying "just work" against the correct hosted Solr core. Because each Acquia environment (prod/dev/test) maps to specific cores, the module discovers the list of *possible* cores for your subscription and picks a *preferred* core automatically, exposing this through Drush and an internal `PreferredCoreService`. To protect shared cores it enforces a **read-only** mode on non-production or ambiguous environments so a staging copy cannot overwrite production's index. It also lets you pin a specific core with `override_search_core`, tune per-index query behavior (the eDisMax parser), and reacts to Search API server/index load and query events to swap in the Acquia connector and apply read-only flags. Deletion of its default server and index is blocked via a `hook_entity_operation_alter`. A live index requires network access to Acquia and a valid subscription, so on a disconnected/local site the module installs and configures but cannot actually reach Solr.

---

- Add Acquia's hosted Solr as a Search API server without hand-writing the Solr connection config
- Authenticate Solr requests with the Acquia subscription (HMAC) instead of storing raw Solr credentials
- Index Drupal content (nodes, users, etc.) into Acquia's managed Solr cores through Search API
- Power a site search page or Views-based search backed by Acquia Solr
- Automatically select the correct Solr core for the current Acquia environment (prod vs. dev/test)
- List every Solr core available to your subscription with `drush acquia:search-solr:cores`
- Discover which cores are *possible* for a given Search API server with `acquia:search-solr:cores:possible`
- Show the *preferred* core the module would use for a server via `acquia:search-solr:cores:preferred`
- Reset the cached list of subscription cores after a subscription change with `acquia:search-solr:cores:cache-reset`
- Pin a specific Solr core by hand with the `override_search_core` setting (e.g. to share one core across environments)
- Enforce read-only mode so a non-production copy cannot write to a shared production index
- Point the module at a non-default Acquia Search API host via the `api_host` setting
- Enable the eDisMax query parser per index to improve relevance and multi-field matching
- Protect the default `acquia_search_server` / `acquia_search_index` from accidental deletion in the UI
- Get a turnkey demo index and search view by enabling the `acquia_search_defaults` submodule
- Migrate a Drupal 7 Acquia Search index and its settings using the bundled migrate plugins
- Alter the list of candidate cores programmatically via `hook_acquia_search_get_list_of_possible_cores_alter()`
- Force or lift read-only enforcement in code with `hook_acquia_search_should_enforce_read_only_alter()`
- Subscribe to `AcquiaSearchEvents` to observe or modify Solr pre-query behavior
- Diagnose connection problems from the Search API server status page (module surfaces read-only / unavailable-core warnings)
- Run Solr-backed faceted search (with the Facets module) on an Acquia-hosted core
- Keep search working across an Acquia Cloud deploy pipeline where each environment binds to its own core
