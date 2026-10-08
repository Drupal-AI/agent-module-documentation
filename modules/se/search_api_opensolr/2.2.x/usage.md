<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API opensolr extends Search API Solr with Solr Connector plugins and admin tooling for the hosted [opensolr.com](https://opensolr.com) SaaS — letting you register/connect an opensolr account, auto-create a core and a matching Search API server, and upload the Solr config to opensolr, all from Drupal.

---

The module builds on `search_api_solr`. It adds two Solr Connector plugins — `opensolr` (extends the
Standard connector) and `basic_auth_opensolr` ("Opensolr with Basic Auth", recommended) — that populate
the connection/auth settings from your opensolr account so you only pick a core from a select list. A
global settings form (`admin/config/search/search-api/opensolr`, permission
`administer search_api_opensolr`) stores your opensolr **email** and **API key**; if the optional Key
module is installed the key is stored as a Key entity (auto-created with the `config` provider),
otherwise as a raw config value (`api_key_raw`). A "Get started" multistep form can register a brand-new
opensolr account (email → activation code → account) and write the credentials back to config; an
"Autoconfigure" form creates a core in your chosen opensolr environment plus the connected Search API
server and uploads the config.zip. All opensolr calls go through an `OpenSolrBase` service (hardcoded
endpoint `https://opensolr.com/solr_manager/api`) with per-component service classes
(`OpenSolrIndex`, `OpenSolrConfigFiles`, `OpenSolrAccount`). A `ZipManager` builds the Solr config zip
from Search API Solr's own config set and POSTs it to opensolr; zip import/upload routes are gated by
`search_api_server.edit` entity access. A bundled submodule, **search_api_opensolr_security**, manages
per-core HTTP Basic Auth credentials and IP allow-lists on opensolr. Every admin route here requires
`administer search_api_opensolr` (or server-edit access); there are no Drush commands and no config
schema file.

---

- Use opensolr.com hosted Solr as the search backend for a Drupal Search API index.
- Register a new opensolr account directly from Drupal via the "Get started" form.
- Connect an existing opensolr account by entering its email + API key.
- Store the opensolr API key as a Key entity (with the optional Key module) instead of raw config.
- Auto-create an opensolr core and a matching Search API server in one step (Autoconfigure).
- Pick an opensolr Solr environment/region best suited to the site.
- Add a Search API server using the "Opensolr with Basic Auth (recommended)" connector.
- Have Basic Auth username/password prefilled automatically from the selected opensolr core.
- Select the opensolr core for a server from a dropdown of your account's cores.
- Upload the Solr config.zip to opensolr automatically when a server is created.
- Manually (re)upload the config.zip to an opensolr core from the server's Opensolr tab.
- Re-import individual config files that failed to upload.
- Test connectivity/credentials to opensolr before saving ("Test connection").
- View index disk usage and monthly bandwidth quotas in the server's view settings.
- Reload, optimize, or commit an opensolr core programmatically via the API services.
- Create or delete opensolr cores programmatically (`OpenSolrIndex::createCore/deleteCore`).
- Replicate one opensolr index into another.
- Set or remove HTTP Basic Auth on a core (security submodule).
- Add or remove IP allow-list entries for a core's query/admin handlers (security submodule).
- Run a Solr-backed site search without hosting/operating your own Solr server.
- Migrate an existing Search API Solr setup to opensolr by swapping the connector.
- Manage sensitive opensolr credentials centrally with the Key module.
