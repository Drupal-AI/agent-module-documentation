<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API opensolr — agent index

Extends `search_api_solr` to use the hosted **opensolr.com** SaaS: Solr Connector plugins plus admin
tooling to guide account connection, autoconfigure a core + Search API server, and upload Solr config.
Depends on `search_api_solr`; optional `key` (now an explicit opt-in). Config UI:
`search_api_opensolr.opensolr_config_form`. One permission (`administer search_api_opensolr`); no Drush;
config object is now schema-typed (`config/schema/search_api_opensolr.schema.yml`).

- **Global credentials (email + API key), the `use_key_module` opt-in, Key integration, test connection**
  → [configure/settings.md](configure/settings.md)
- **The setup flows: Get started (guided status page), Autoconfigure, add server, config-zip import** →
  [configure/setup.md](configure/setup.md)
- **The two Solr Connector plugins (`opensolr`, `basic_auth_opensolr`) and how they self-fill settings**
  → [plugins/connectors.md](plugins/connectors.md)
- **The opensolr API service layer (`OpenSolrBase` + Index/ConfigFiles components) for code** →
  [api/api.md](api/api.md)

Submodule:
- `search_api_opensolr_security` (per-core HTTP auth + IP allow-list) →
  [../../modules/search_api_opensolr_security/2.2.x/agent/start.md](../../modules/search_api_opensolr_security/2.2.x/agent/start.md)

Key facts:
- Config object `search_api_opensolr.opensolrconfig` → `use_key_module` (bool) +
  `opensolr_credentials.{email, api_key, api_key_raw}` (ships **empty** — no shipped secret). With the Key
  opt-in on, `api_key` holds a Key entity id; otherwise `api_key_raw` holds the plain key.
- All calls hit the hardcoded endpoint `https://opensolr.com/solr_manager/api` (`OpenSolrBase`); not
  config-overridable. Guzzle TLS verification is left at its default (on). Credentials are scrubbed from
  logs/messages (`OpenSolrResponse::redactCredentials()`).
- Admin routes require `administer search_api_opensolr`; config-zip/files import require
  `search_api_server.edit` entity access.
- See [Diff 2.2.x → 2.4.x](#diff-22x--24x) below for what changed.

## Diff 2.2.x → 2.4.x

- **Get started rewritten.** The old multistep **registration wizard** (a `_form` that drove an opensolr
  account-creation API — `sendEmailCode` / `createAccount`) is gone. `get_started_form` is now a
  `_controller` (`GetStartedController::page`) rendering a **guided 4-step status page** (theme
  `opensolr_get_started`) that ticks off completed steps. Accounts are created only on opensolr.com. The
  `OpenSolrAccount` API component and its `search_api_opensolr.account` service were removed.
- **Key integration is an explicit opt-in** (issue #3576419). New `use_key_module` boolean config plus a
  checkbox on the settings form. Merely installing Key no longer silently switches key storage.
- **Config schema added** (`config/schema/search_api_opensolr.schema.yml`). The config object is now
  typed (`provides_config_schema` is true; it was false in 2.2.x).
- **New `KeyModuleUninstallValidator`** blocks uninstalling Key while `use_key_module` is on (the Key
  entity holds the API key).
- **Drupal 12 readiness** (#3602784): OOP hook classes (`src/Hook/*`), `hook_entity_operation`
  cacheability param, phpstan fixes.
- **Hardened API error handling** (#3533991/#3533996/#3576417): failed opensolr calls never crash the
  admin UI (`OpenSolrBase::buildErrorResponse()`), credentials are redacted from logs/messages
  (`OpenSolrResponse::redactCredentials()`), and reads use immutable config.
