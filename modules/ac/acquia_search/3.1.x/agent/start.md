<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_search — agent start

Integrates Drupal with **Acquia's hosted Solr** search. It is a thin layer on top of
**search_api_solr**: it adds a Solr connector (`solr_acquia_connector`) and a Search API
backend (`acquia_search_solr`) that sign requests with the site's **acquia_connector**
subscription (HMAC), ships a default Search API server (`acquia_search_server`) plus a
settings object (`acquia_search.settings`), auto-selects the right Solr core per Acquia
environment, and enforces read-only mode to protect shared cores. Package **Acquia**.
Requires `acquia_connector`, `search_api_solr`, `views`. **No admin form of its own** —
you configure it through the Search API server UI plus the `acquia_search.settings` keys.
A live index needs network access to Acquia and a valid subscription; without one the
module installs and configures but cannot reach Solr.

- Settings keys, the default server/index, read-only mode, pinning a core → [configure/acquia_search.md](configure/acquia_search.md)
- Drush commands (list / possible / preferred cores, cache reset) → [drush/commands.md](drush/commands.md)
- Services, PreferredCoreService, API client, events → [api/services.md](api/services.md)
- Hooks it invites (possible-cores alter, read-only alter) → [hooks/alters.md](hooks/alters.md)
- Submodule: turnkey demo index + search view → [../../modules/acquia_search_defaults/3.1.x/agent/start.md](../../modules/acquia_search_defaults/3.1.x/agent/start.md)
