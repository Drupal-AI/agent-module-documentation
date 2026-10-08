<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# search_api_pantheon — agent start

Auto-configures Search API Solr for the Apache Solr (8/9) add-on hosted on Pantheon.
Enabling the module installs a **Pantheon Search** server (`pantheon_search`, backend
`search_api_solr`, connector `pantheon`) and a **Primary** index (`primary`) — no host,
port, or core is entered by hand. The `pantheon` SolrConnector extends Search API Solr's
`StandardSolrConnector` and force-overrides connection settings from Pantheon environment
variables, so one exported config follows the code across Dev/Test/Live/Multidev (each has
its own Solr core). No `configure` route of its own; you manage the server/index through
Search API at `/admin/config/search/search-api`. Only works on Pantheon (needs
`PANTHEON_ENVIRONMENT`); depends on `search_api_solr`.

- Server + index config, env-var overrides, `pantheon.yml`/add-on setup → [configure/setup.md](configure/setup.md)
- Drush commands (postSchema, reloadSchema, diagnose, ping, select, test-index-and-query, view-schema, force-cleanup) → [drush/commands.md](drush/commands.md)
- The `pantheon` SolrConnector + SchemaPoster service internals → [api/services.md](api/services.md)
- Submodules: `search_api_pantheon_admin` (obsolete as of 8.4.x — see its own doc); `search_api_pantheon_examples` (example module, not documented).
