<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure key_auth settings

Config object: **`key_auth.settings`** (schema `config/schema/key_auth.schema.yml`).
Configure route: **`key_auth.settings`** at **`/admin/config/services/key-auth`**
(permission `administer site configuration`), form `Drupal\key_auth\Form\KeyAuthSettingsForm`.

## Settings keys and shipped defaults

`config/install/key_auth.settings.yml`:

```yaml
auto_generate_keys: true
key_length: 32
param_name: 'api-key'
detection_methods:
  - header
  - query
```

| Key | Type | Default | Meaning |
|---|---|---|---|
| `auto_generate_keys` | bool | `true` | On user creation, auto-assign a key to any new user who has the `use key authentication` permission (`key_auth_user_insert()`). |
| `key_length` | int | `32` | Character length of generated keys (min 8, max 255 in the settings form). `KeyAuth::generateKey()` truncates a hex string to exactly this many characters. |
| `param_name` | string | `api-key` | The name of the HTTP header and/or query parameter clients use to send their key. |
| `detection_methods` | sequence of string | `[header, query]` | Which of `header` / `query` the auth provider checks (`KeyAuth::DETECTION_METHOD_HEADER`, `::DETECTION_METHOD_QUERY`). Both may be enabled, either alone, or (unusually) neither. |

## How detection actually works (`KeyAuth::getKey()`)

For each request, in this order:
1. If `header` is in `detection_methods`, look for a request **header** literally named
   `param_name` (`$request->headers->get($param_name)`) — e.g. with the default `api-key`,
   a client sends `api-key: <key>`. Header lookups are case-insensitive per HTTP/Symfony
   convention.
2. If `query` is in `detection_methods`, look for a **query string parameter** named
   `param_name` (`$request->query->get($param_name)`) — e.g. `?api-key=<key>`.
3. The header is checked first; if both are enabled and a key is found in the header, the
   query string is not consulted. If no key is found by either enabled method, `getKey()`
   returns `FALSE` and the `key_auth` authentication provider does not apply to the request.

Changing `param_name` changes **both** the header name and the query parameter name (they
always share one name). Disabling both methods effectively turns key authentication off.

## Via the UI

1. Go to **Configuration → Web services → Key authentication**
   (`/admin/config/services/key-auth`).
2. Set **Automatically generate a key when users are created**, **Key length**,
   **Parameter name**, and tick one or both **Detection methods** (Header / Query).
3. Save configuration.

## Via drush

```bash
drush cget key_auth.settings
drush cset key_auth.settings param_name 'x-api-token'
drush cset key_auth.settings key_length 48
```

`detection_methods` is a sequence, so set it with `php:eval` rather than `cset`:

```bash
drush php:eval "\Drupal::configFactory()->getEditable('key_auth.settings')->set('detection_methods', ['header'])->save();"
```

## Related: the `use key authentication` permission

Regardless of these settings, a key only authenticates a request (and a user only receives
an auto-generated key) if the matched user's role(s) grant the permission
**`use key authentication`**, checked by `KeyAuth::access()`. This is set on roles at
`/admin/people/permissions`, not in `key_auth.settings`.
