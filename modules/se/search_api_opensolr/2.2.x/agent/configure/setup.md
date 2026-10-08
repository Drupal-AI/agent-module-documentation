<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup flows: get started, autoconfigure, add server, config zip

All routes below require `administer search_api_opensolr`, except the config import routes which require
`search_api_server.edit` entity access.

## 1. Get started — register a new opensolr account

Route `search_api_opensolr.get_started_form` → `/admin/config/search/search-api/opensolr/get-started`
(`GetStartedForm`, a multistep form using its own private tempstore `opensolr_get_started`). Steps
(`src/Form/Multistep/`): `StepPrerequisites` (do you already have an account?), `StepRegistration`
(enter email → `OpenSolrAccount::sendEmailCode()`), `StepEmailVerification` (enter the activation code →
`OpenSolrAccount::createAccount(email, code, password)`). On success the returned API key + email are
written to `search_api_opensolr.opensolrconfig`, then you're redirected to Autoconfigure. Skip this if
you already have opensolr credentials.

## 2. Autoconfigure — core + server in one go

Route `search_api_opensolr.autoconfigure_form` → `.../opensolr/autoconfigure` (`AutoConfigureForm`,
uses `AutoConfig` / `AutoConfigBatch`). Presents the compatible opensolr environments
(`OpenSolrIndex::getEnvironments()`); pick one and **Start**. It creates an opensolr core
(`createCore`), creates a Search API Solr **server** wired to the `basic_auth_opensolr` connector for
that core, and uploads the config.zip.

## 3. Add a server manually

Search API → **Add server** → Solr Connector **"Opensolr with Basic Auth (recommended)"**. The connector
form (see [../plugins/connectors.md](../plugins/connectors.md)) lists your account's cores; choose one.
Basic Auth username/password are prefilled from the core and hidden. On save,
`ServerOperations` triggers `ZipManager::importConfigZip()` to build and POST the config.zip to opensolr.

## 4. Config zip / files import (fallback)

If the automatic upload fails, the server's **Opensolr** tab exposes:

- `search_api_opensolr.opensolr_config_zip_import` → `.../opensolr-zip-import/{search_api_server}`
  (`OpenSolrConfigZipImport`) — upload a config.zip.
- `search_api_opensolr.opensolr_config_files_import` → `.../opensolr-files-import/{search_api_server}`
  (`OpenSolrConfigFilesImport`) — re-upload individual files that failed.

Both require `_entity_access: search_api_server.edit`, and their local-action visibility is further
gated by `LocalActionAccessCheck` (only shows for servers actually using an opensolr connector).

## The config.zip

`ZipManager::processZip()` builds the zip from Search API Solr's own generated config set
(`SolrConfigSetController::getConfigFiles()`), stripping `<updateLog>` from `solrconfig.xml`, then
`OpenSolrConfigFiles::uploadZipConfigFiles()` POSTs it. The zip content comes from Drupal's trusted
Solr config, not from user uploads (aside from the admin-provided file on the manual import route).
