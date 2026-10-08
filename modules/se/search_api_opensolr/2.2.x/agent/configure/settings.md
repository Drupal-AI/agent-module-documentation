<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# opensolr credentials & settings

Form: `admin/config/search/search-api/opensolr` (`OpenSolrConfigForm`, permission
`administer search_api_opensolr`). You enter your opensolr **email** and **API key** (from your
opensolr dashboard) and can **Test connection** before saving.

## Where credentials live — `search_api_opensolr.opensolrconfig`

Ships empty (`config/install`):

```yaml
opensolr_credentials:
  email: ''
  api_key: ''       # a Key entity id, when the Key module is used
  api_key_raw: ''   # the raw API key, when Key is NOT used
```

Managed by the `search_api_opensolr.config` service (`Services/OpenSolrConfig.php`):

- `getApiCredentials()` returns `{email, api_key}` with the API key **resolved** — if Key is installed
  it reads the key value from the referenced Key entity, otherwise it uses `api_key_raw`.
- `setApiKey($key)`: with the Key module it calls `createKey()` to make a new Key entity (id
  `opensolr_<uniqid>`, `key_type: authentication`, `key_provider: config`) and stores that key's id in
  `api_key`; without Key it stores the value in `api_key_raw`.
- `setEmail()` / `getEmail()` read/write `opensolr_credentials.email`.

## Key module (optional)

`composer require drupal/key` + `drush en key`. Then on the settings form you can select an existing Key
or follow the "create a new key" link. This lets the API key be provided by env/file providers rather
than living in config. Without Key, the raw key is stored in `api_key_raw` (a normal config value that an
operator may still override via `settings.php`/env if desired).

## Notes

- There is **no config schema file** in the module; the config object is a plain settings store.
- The endpoint is hardcoded (`OpenSolrBase::OPENSOLR_ENDPOINT_URL = https://opensolr.com/solr_manager/api`)
  — credentials are attached to each request by `apiCall()`.
- Every setting here is behind `administer search_api_opensolr`; the credentials default to empty (the
  module ships no key of its own).
