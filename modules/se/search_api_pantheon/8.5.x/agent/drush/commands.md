<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `drush.services.yml` (`src/Commands/*`). Diagnostic commands automatically use
the first server connected via the Pantheon connector — no `server_id` argument. On Pantheon,
run through Terminus: `terminus drush <site>.<env> -- <command>`.

| Command | Alias | Args | Purpose |
|---|---|---|---|
| `search-api-pantheon:postSchema` | `sapps` | `[path]` (optional) | Upload/post schema files to the Solr server; auto-reloads the core afterward. Resets, upgrades, or applies a custom schema. |
| `search-api-pantheon:reloadSchema` | — | none | Manually reload the Solr core (re-applies the posted schema). |
| `search-api-pantheon:view-schema` | `sapvs` | `<filename>` | Print a schema file currently on the Solr server (e.g. `schema.xml`, `elevate.xml`). |
| `search-api-pantheon:diagnose` | `sapd` | none | Check every piece of the Search API/Solr install and error on broken parts. |
| `search-api-pantheon:ping` | `sapp` | none | Ping the Solr host to confirm reachability. |
| `search-api-pantheon:select` | `saps` | `<query>` (required) | Run a raw query against Solr (append `?debug=true` on a Solr page to get a good query string). |
| `search-api-pantheon:test-index-and-query` | `sap-tiq` | none | Smoke test: connect, index a single item, immediately query it back. |
| `search-api-pantheon:force-cleanup` | `sapfc` | none | Delete all contents of the Solr server regardless of hash/index_id (recover from corruption). |

## `postSchema [path]`
- **No path** → uses Search API Solr to generate a config-set matching your installed
  `search_api_solr` version and Solr version, then posts it.
- **Jump-start config-set** (known baseline, no site customizations):
  ```bash
  drush search-api-pantheon:postSchema /code/web/modules/contrib/search_api_solr/jump-start/solr9/config-set/
  drush search-api-pantheon:postSchema /code/web/modules/contrib/search_api_solr/jump-start/solr8/config-set/
  ```
- **Custom config-set** (own analyzers/tokenizers/field types):
  ```bash
  drush search-api-pantheon:postSchema /code/solr/config
  ```

Re-run `postSchema` after: initial install, adding new Solr field types, upgrading
`search_api_solr` (e.g. 4.2.x → 4.3.x), switching Solr 8↔9, or toggling Search API Solr
sub-modules. The command reloads the core automatically to stop the schema reverting.
