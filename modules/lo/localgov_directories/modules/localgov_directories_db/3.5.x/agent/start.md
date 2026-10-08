<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories Database (localgov_directories_db) — agent index

Config-only submodule of [localgov_directories](../../../../3.5.x/agent/start.md). Supplies the
Search API **database** server and attaches the directories index to it. No routes, no
permissions, no schema, no Drush, no PHP beyond install/uninstall hooks.

Key facts:
- Depends on `localgov_directories` and `search_api:search_api_db`.
- `config/install/search_api.server.localgov_directories_default.yml` — the database server.
- `config/conditional/search_api.index.localgov_directories_index_default.yml` — the index
  configuration used as the source of **processors** on install (the index entity itself is owned
  by the parent module).
- `hook_install($is_syncing)` runs only when **not** syncing config **and** the existing
  `localgov_directories_index_default` index has an empty server id:

  ```php
  $index->setProcessors($new_config_index->getProcessors());
  $index->setServer(Server::load('localgov_directories_default'));
  $index->setStatus(TRUE);
  $index->save();
  ```

  So installing this module never overrides an index that is already pointed at Solr — the guard
  is the server-id emptiness check, not a config-import decision.
- `hook_uninstall()` detaches the server again so the index is not left dangling.

Usage notes:
- Choosing Solr instead: **uninstall this submodule first**
  (`drush pm:uninstall localgov_directories_db -y`), then attach the index to your Solr server.
  The parent module's README says the same.
- After install, build the index: `drush search-api:index localgov_directories_index_default`.
- Verify wiring: `drush search-api:list` (index → server) and
  `drush cget search_api.index.localgov_directories_index_default server`.
