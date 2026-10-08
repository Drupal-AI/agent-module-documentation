<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# opensolr credentials & settings

Form: `admin/config/search/search-api/opensolr` (`OpenSolrConfigForm`, permission
`administer search_api_opensolr`). You enter your opensolr **email** and **API key** (from your
opensolr dashboard), choose whether to store the key with the Key module, and can **Test connection**
before saving.

## Where credentials live — `search_api_opensolr.opensolrconfig`

Ships empty (`config/install`):

```yaml
use_key_module: false
opensolr_credentials:
  email: ''
  api_key: ''       # a Key entity id, when the Key opt-in is on
  api_key_raw: ''   # the raw API key, when the Key opt-in is off
```

There is now a **config schema** for this object (`config/schema/search_api_opensolr.schema.yml`).

Managed by the `search_api_opensolr.config` service (`Services/OpenSolrConfig.php`):

- `getApiCredentials()` returns `{email, api_key}` with the API key **resolved** — when the Key opt-in is
  in use it reads the value from the referenced Key entity, otherwise it uses `api_key_raw`.
- `extractApiCredentials($credentials, ?bool $useKey = NULL)` resolves the key for an arbitrary
  credentials array; the config form passes the (possibly unsaved) checkbox value so "Test connection"
  honours what you are about to save. If the referenced Key entity is missing it falls back to
  `api_key_raw` so an existing setup keeps working.
- `setApiKey($key)`: when the Key integration is enabled it calls `createKey()` to make a new Key entity
  (id `opensolr_<uniqid>`, `key_type: authentication`, `key_provider: config`) and stores that key's id in
  `api_key`; otherwise it stores the value in `api_key_raw`.
- `setEmail()` / `getEmail()` read/write `opensolr_credentials.email`.

## Key module — now an explicit opt-in (issue #3576419)

`composer require drupal/key` + `drush en key`, then tick **"Store the API key with the Key module"** on
the settings form. The `use_key_module` boolean gates the integration: merely having Key installed no
longer switches key storage — you must opt in. With the opt-in on you select an authentication-group Key
(or create one). Without it, the raw key is stored in `api_key_raw`.

`KeyModuleUninstallValidator` prevents uninstalling the Key module while `use_key_module` is on (the Key
entity holds the live API key); switch back to direct storage first.

## Notes

- The endpoint is hardcoded (`OpenSolrBase::OPENSOLR_ENDPOINT_URL = https://opensolr.com/solr_manager/api`)
  and not overridable; credentials are attached to each request by `apiCall()` and redacted from any log
  or message via `OpenSolrResponse::redactCredentials()`.
- Every setting here is behind `administer search_api_opensolr`; the credentials default to empty (the
  module ships no key of its own).
- **Test connection** (`::testConnectionSubmit`) calls `OpenSolrIndex::getIndexList()` with the
  currently-entered credentials and reports success/failure without saving.
