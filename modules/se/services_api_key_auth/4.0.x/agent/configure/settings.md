# Where the key is read from (`services_api_key_auth.settings`)

A settings form controls which request location the provider reads the API key from. It is not the
key store — keys live in `api_key` entities (see [api-keys.md](api-keys.md)).

- Form: `Drupal\services_api_key_auth\Form\ApiKeyAuthSettingsForm`, form id
  `services_api_key_auth_api_key_auth_settings`.
- Route: `services_api_key_auth.api_key_auth_settings` → `/admin/config/services/api-key-auth/settings`
  (perm `administer services_api_key_auth`; also linked as the "General settings" action/tab on the
  key collection).
- Config object: `services_api_key_auth.settings`.

## Config keys (schema `services_api_key_auth.schema.yml`)

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `api_key_request_header_name` | string | `api_key` | Name of the **request header** carrying the key. Empty = disable the header path. |
| `api_key_post_parameter_name` | string | `''` (empty) | Name of the **POST body** field carrying the key. Empty = disabled. |
| `api_key_get_parameter_name` | string | `''` (empty) | Name of the **query-string** parameter carrying the key. Empty = disabled. |

`getKey()` checks header → POST → GET in that order and uses the first non-empty value found; a name
left empty skips that source. Fresh installs ship with only the header path enabled.

Operational note: whichever source(s) are enabled, the provider's `applies()` runs on every request
to this site — the form's own field descriptions state "the value of this key will be checked on
EVERY request for this site." Prefer the header over the query-string path (query strings appear in
access logs, `Referer` headers, browser history and proxy logs).

## Upgrade note

Sites upgrading from a pre-4.x version run `hook_update_10001`, which sets
`api_key_request_header_name` to `apikey` (no underscore) and both
`api_key_post_parameter_name` and `api_key_get_parameter_name` to `api_key` — i.e. an upgraded site
has all three transports enabled, unlike a fresh install. Review the values after upgrading.

## Setting values

```bash
# Read the key from an X-API-Key header, disable POST/GET:
drush config:set services_api_key_auth.settings api_key_request_header_name 'X-API-Key' -y
drush config:set services_api_key_auth.settings api_key_post_parameter_name '' -y
drush config:set services_api_key_auth.settings api_key_get_parameter_name '' -y
```
```php
\Drupal::configFactory()->getEditable('services_api_key_auth.settings')
  ->set('api_key_request_header_name', 'X-API-Key')
  ->save();
```
