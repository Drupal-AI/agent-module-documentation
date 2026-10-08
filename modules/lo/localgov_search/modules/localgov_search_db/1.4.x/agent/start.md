<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Search Database (localgov_search_db) — agent index

Config-only submodule of [localgov_search](../../../../1.4.x/agent/start.md) providing the Search
API **database** server and attaching the sitewide index to it.

Key facts:
- Depends on `localgov_search` and `search_api:search_api_db`.
- `config/install/search_api.server.localgov_sitewide_search.yml` — the database server.
- `config/conditional/search_api.index.localgov_sitewide_search.yml` — the source of **processors**
  applied to the live index on install.
- `hook_install($is_syncing)` acts only when **all** of these hold:
  1. not syncing config,
  2. `Index::load('localgov_sitewide_search')` exists,
  3. that index's `getServerId()` is empty.

  Then: copy processors from the conditional config, `setServer()`, `setStatus(TRUE)`, `save()`.
  A site already using Solr keeps its server.
- `hook_uninstall()` detaches the server.

Switching to Solr:

```bash
drush pm:uninstall localgov_search_db -y
# create/attach your Solr server, then:
drush cset search_api.index.localgov_sitewide_search server my_solr_server -y
drush search-api:index localgov_sitewide_search
```

Verify wiring at any time:

```bash
drush search-api:list
drush cget search_api.index.localgov_sitewide_search server
```
