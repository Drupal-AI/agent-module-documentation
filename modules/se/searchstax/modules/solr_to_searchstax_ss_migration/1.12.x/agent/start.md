<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Solr → SearchStax Site Search Migration — agent index

Submodule of **SearchStax** (`part_of: searchstax`). A one-off tool for migrating a generic
Solr Search API server into SearchStax Site Search, then uninstalled. Depends on `searchstax`
and `search_api_solr`.

- Configure route: `solr_to_searchstax_ss_migration.overview`
  (`/admin/config/search/solr-to-searchstax-ss-migration`), permission `administer search_api`.
- Running a real migration needs a live SearchStax subscription + network access.

## Routes (`*.routing.yml`)

- `solr_to_searchstax_ss_migration.overview` — lists migratable Solr servers.
- `solr_to_searchstax_ss_migration.migrate_server_form` —
  `/admin/config/search/solr-to-searchstax-ss-migration/migrate-server/{server_id}`.

Both gate on `administer search_api`. No permissions or config schema of its own.

## Drush commands (`src/Drush/Commands/SearchStaxMigrationCommands.php`)

- `searchstax:set-auth-token <token> [--expire=SECONDS]` — set a currently-valid SearchStax
  auth token (default TTL 24h) so the other commands can run headlessly.
- `searchstax:migrate-server <server_id> [--account --app-id --languages --copy-from-view]` —
  migrate a Solr server's config into a SearchStax account/app.
- `searchstax:copy-index <index_id>` — copy a Search API index onto a freshly migrated
  SearchStax server.

See the parent module docs at `../../../1.12.x/agent/start.md`.
