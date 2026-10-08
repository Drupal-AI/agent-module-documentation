<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: the status-report schema check (`hook_requirements`)

`search_api_solr_schema_check_requirements($phase)` (`search_api_solr_schema_check.install:21`) is the
module's core. It runs **only** for `$phase === 'runtime'`, i.e. it renders on the Status report
(`/admin/reports/status`, route `system.status`) and whenever `hook_requirements('runtime')` is
collected. There is no install-phase check.

## What it iterates

```php
$servers = search_api_solr_get_servers();   // upstream: active servers only by default
```

For each server it reads `search_api.server.<id>` → `backend_config.repo_path` (see
[configure/repo-path.md](../configure/repo-path.md)). A server is **skipped** unless **all** of these hold:

1. `repo_path` is non-empty.
2. `$server->status()` — the server is enabled.
3. `$backend->isAvailable() && $connector->pingCore()` — the Solr backend answers and the core pings.
4. `!$backend->isNonDrupalOrOutdatedConfigSetAllowed()` — the backend is **not** configured to tolerate a
   non-Drupal / outdated config set (if it is, drift is expected and the check is intentionally silent).
5. The repo directory contains at least one file (`$new_config_set` non-empty).

(`$backend = $server->getBackend()`, `$connector = $backend->getSolrConnector()`.) A
`SolrConfigSetController` is instantiated with the `extension.list.module` service and `setServer()`,
but the comparison itself uses `Utility::getServerFiles()` and the connector directly.

## Reading the repo directory

`opendir()`/`readdir()` over `repo_path`, skipping `.`/`..` and any entry that `is_dir()` (so only files
directly in the directory, non-recursive). Each file's contents are loaded with `file_get_contents()`
into `$new_config_set[$filename] = <body>`.

## What it compares and the rows it emits

`$server_files_list = Utility::getServerFiles($server)` lists the files currently on the Solr server
(empty list on `SearchApiSolrException`). Then:

- **Missing files.** `array_diff(repo file names, server file names)` — any file in your repo not on the
  server produces one requirement:
  - key `search_api_solr_schema_<server_id>_modifications`
  - title `Solr Server <label>`, value **"Schema incomplete"**, severity **`REQUIREMENT_WARNING`**
  - description lists the missing `@files` and links the server; advises downloading/deploying an updated
    `config.zip`.

- **Per-`.xml`-file content diff.** For each repo file whose name ends in `.xml` (detected via
  `stripos(strrev($name), 'lmx.') === 0`), it fetches the server's copy with
  `$connector->getFile($name)->getBody()` (empty string on `SearchApiSolrException`), runs **both** bodies
  through `Utility::normalizeXml()` (which strips volatile bits and returns `[version, normalizedXml]`),
  and `strcmp()`s the normalized XML:
  - key `search_api_solr_schema_<server_id>_modifications_<filename>`
  - **differ** → value **"Schema not up to date"**, severity **`REQUIREMENT_ERROR`**.
  - **equal** → value **"Schema up to date"**, severity **`REQUIREMENT_OK`** (an explicit "no differences"
    confirmation row, one per xml file).

Non-`.xml` files only participate in the missing-files (presence) check, not the content diff.

## Operational notes

- Because it keys on `runtime`, wiring `/admin/reports/status` (or `drush core:requirements`) into a
  deploy/CI step turns schema drift into a readable pass/fail signal.
- All requirement descriptions pass entity labels, file names and the server URL through `t()`
  placeholders — no raw user input is echoed. Reading the report requires the `access site reports`
  permission; the check reads only the admin-configured local directory.
