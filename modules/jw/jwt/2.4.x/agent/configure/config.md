<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the JWT signing key

JWT signs and verifies with a **single site-wide Key entity** (from the `key` module).
Configuration is two steps: create the Key, then point `jwt.config` at it.

## Config object

`jwt.config` (config_object, schema `jwt.schema.yml`):

| Key | Type | Notes |
|---|---|---|
| `key_id` | string | Machine name of the chosen Key entity. |
| `algorithm` | string | Present in schema; in practice the algorithm is read from the Key's own config, not this field. |

**`jwt.config` does not exist on a freshly enabled site** — it is created the first time you
save the config form. Route: `jwt.jwt_config_form` at `/admin/config/system/jwt`, permission
`administer jwt`. The form's key select is filtered to key types `jwt_hs` and `jwt_rs`, and it
rejects a key whose type does not match its algorithm.

## The two JWT key types

The module registers two `key` KeyType plugins (implementations, not a new plugin type):

- `jwt_hs` — **JWT HMAC Key**, symmetric. Algorithms `HS256` (min 256-bit), `HS384`, `HS512`.
  Key value is a raw secret (`text_field`); the transcoder uses it for both sign and verify.
- `jwt_rs` — **JWT RSA Key**, asymmetric. Algorithm `RS256` (min 2048-bit). Key value is a PEM
  private or public key (`textarea_field`); private signs (encode), public verifies (decode).

Both can auto-generate a strong value from the Key add form (`generateKeyValue()`).

## Create an HMAC key + point JWT at it (drush / php:eval)

```php
// 1. Create a jwt_hs Key with an inline HS256 secret (>= 32 bytes).
$key = \Drupal\key\Entity\Key::create([
  'id' => 'my_jwt_hmac',
  'label' => 'My JWT HMAC',
  'key_type' => 'jwt_hs',
  'key_type_settings' => ['algorithm' => 'HS256'],
  'key_provider' => 'config',
  'key_provider_settings' => ['key_value' => str_repeat('a', 64)],
])->save();

// 2. Point jwt.config at it (this creates jwt.config).
\Drupal::configFactory()->getEditable('jwt.config')->set('key_id', 'my_jwt_hmac')->save();
```

## Read it back

```bash
drush cget jwt.config key_id
# or, if unsure it exists:
drush cget jwt.config 2>&1        # "Config jwt.config does not exist" until first save
```

The Key itself is a config entity `key.key.<id>` — inspect with `drush cget key.key.my_jwt_hmac`
(its `key_type` and `key_type_settings.algorithm` decide HS vs RS and the signing algorithm).

## Permission

`administer jwt` (title "Administer JSON Web Token module", `restrict access: TRUE`) gates the
JWT admin pages, including this config form and the path-auth form added by `jwt_path_auth`.
