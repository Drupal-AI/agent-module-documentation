<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Solr Schema Check (search_api_solr_schema_check) — agent index

Adds a **Status report** check that compares each **Search API Solr** server's *live* schema against a
**canonical schema** you keep on disk (typically the Solr config committed to your git repo). You point
each server at that directory; on every `/admin/reports/status` load the module reads the files in that
directory, fetches the corresponding files the Solr core is actually running (via the server's Solr
connector), and flags drift — missing files and, for `.xml` files, byte-level content differences after
normalization. It is a **diagnostic only**: it reports mismatches, it does not push or reconcile schema.

Mechanism is two hooks and one config key, no routes/services/UI of its own. `hook_form_alter()`
injects a **"Solr config repo path"** textfield into the Solr server's backend config form (under the
backend's *Advanced* group); the value is stored on the Search API server's own config object at
`backend_config.repo_path`. `hook_requirements('runtime')` (in the `.install`) then does the actual
comparison per active server and emits `REQUIREMENT_OK` / `REQUIREMENT_WARNING` / `REQUIREMENT_ERROR`
rows on the status report.

- Depends on: `search_api_solr:search_api_solr` (this module inspects that module's servers/connectors).
- Core: `^10.1 || ^11`. Package: `Search`. No composer library deps, no PHP constraint declared.
- **No dedicated settings page / `configure` route.** Configuration is one field per Solr server
  (`backend_config.repo_path`). No config schema, no permissions, no services, no drush, no plugin types.
- Output surfaces only on the core Status report (`system.status`, `/admin/reports/status`).

## What you'd do → where

- **Tell the module which directory holds a server's canonical Solr config** →
  [configure/repo-path.md](configure/repo-path.md)
- **Understand exactly what the status check compares, its preconditions, and every requirement key/severity it emits** →
  [hooks/requirements.md](hooks/requirements.md)

## Key facts (real machine names)

- Hooks: `search_api_solr_schema_check_form_alter()` (`.module`) — alters form id
  **`search_api_server_edit_form`**; `search_api_solr_schema_check_requirements($phase)` (`.install`) —
  runs only for `$phase === 'runtime'`.
- Config key (per Search API server): **`backend_config.repo_path`** on the config object
  `search_api.server.<server_id>` (read via `config.factory`→`getEditable()`; **no config schema** ships
  for this key). Path is absolute if it starts with `/`, else resolved relative to `DRUPAL_ROOT`.
- Requirement keys emitted (per active server):
  - `search_api_solr_schema_<server_id>_modifications` — value *"Schema incomplete"*, `REQUIREMENT_WARNING`,
    when the repo dir contains files not present on the server.
  - `search_api_solr_schema_<server_id>_modifications_<filename>` — one per `.xml` file: value *"Schema not up
    to date"* / `REQUIREMENT_ERROR` on content diff, else *"Schema up to date"* / `REQUIREMENT_OK`.
- Upstream API used: `search_api_solr_get_servers()` (defaults to active servers only);
  `Drupal\search_api_solr\Utility\Utility::getServerFiles($server)` and `::normalizeXml($xml)`;
  `$server->getBackend()->getSolrConnector()->pingCore()` / `->getFile($name)`;
  `$backend->isAvailable()`, `$backend->isNonDrupalOrOutdatedConfigSetAllowed()`;
  `Drupal\search_api_solr\Controller\SolrConfigSetController`.
- Extension service used: `extension.list.module` (`\Drupal::service('extension.list.module')`).
