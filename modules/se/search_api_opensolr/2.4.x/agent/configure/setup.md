<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup flows: get started, autoconfigure, add server, config zip

All routes below require `administer search_api_opensolr`, except the config import routes which require
`search_api_server.edit` entity access.

## 1. Get started — a guided status page (rewritten in 2.4.x)

Route `search_api_opensolr.get_started_form` → `/admin/config/search/search-api/opensolr/get-started`.
This is now a **`_controller`** (`GetStartedController::page`, theme `opensolr_get_started`), **not a
form**. It renders four steps and ticks the ones already done, with a deep link into each:

1. **Create an Opensolr account** at <https://opensolr.com/register> (15-day free trial). Accounts can
   only be created on opensolr.com — the old in-Drupal registration wizard was removed.
2. **Connect this site** — paste your registration email + API key into *Settings* and *Test connection*.
   Marked done once both email and API key are saved.
3. **Create your Opensolr index and Search API server** via the *Autoconfigure* tab. Marked done once an
   opensolr-connector server exists.
4. **Create your Search API index** — plain Search API from here. Marked done once such an index exists.

Step status is derived from the saved credentials and from the Search API servers/indexes; the page is
cache-tagged accordingly (`config:search_api_opensolr.opensolrconfig`, `search_api_server_list`,
`search_api_index_list`).

## 2. Autoconfigure — core + server in one go

Route `search_api_opensolr.autoconfigure_form` → `.../opensolr/autoconfigure` (`AutoConfigureForm`,
uses `AutoConfig` / `AutoConfigBatch`). Presents the compatible opensolr environments
(`OpenSolrIndex::getEnvironments()`, filtered to Solr ≥ 8); pick one and **Start**. A batch runs two
steps — `STEP_CREATE_CORE` (`createCore`) then `STEP_CREATE_SERVER` — creating an opensolr core, a
Search API Solr **server** wired to the `basic_auth_opensolr` connector for that core, and (on server
insert) uploading the config.zip.

## 3. Add a server manually

Search API → **Add server** → Solr Connector **"Opensolr with Basic Auth (recommended)"**. The connector
form (see [../plugins/connectors.md](../plugins/connectors.md)) lists your account's cores; choose one.
Basic Auth username/password are prefilled from the core and hidden. On save, `ServerOperations::serverInsert()`
triggers `ZipManager::importConfigZip()` to build and POST the config.zip to opensolr (skipped for
cluster/replica index types, which warn you to upload manually).

## 4. Config zip / files import (fallback)

If the automatic upload fails, the server's **Opensolr** tab exposes:

- `search_api_opensolr.opensolr_config_zip_import` → `.../opensolr-zip-import/{search_api_server}`
  (`OpenSolrConfigZipImport`) — upload a config.zip.
- `search_api_opensolr.opensolr_config_files_import` → `.../opensolr-files-import/{search_api_server}`
  (`OpenSolrConfigFilesImport`) — re-upload individual files that failed (names stashed in a private
  tempstore by `ZipManager::processResult()`).

Both require `_entity_access: search_api_server.edit`, and their local-action visibility is further
gated by `LocalActionAccessCheck` (only shows for servers actually using an opensolr connector).

## The config.zip

`ZipManager::processZip()` builds the zip from Search API Solr's own generated config set
(`SolrConfigSetController::getConfigFiles()`), stripping `<updateLog>` from `solrconfig.xml`, then
`OpenSolrConfigFiles::uploadZipConfigFiles()` POSTs it (multipart). The zip content comes from Drupal's
trusted Solr config, not from user uploads (aside from the admin-provided file on the manual import route).
