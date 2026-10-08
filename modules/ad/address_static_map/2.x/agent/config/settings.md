<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site-wide settings & Google credentials

## Route, form, access

- Route **`address_static_map.settings`** (`address_static_map.routing.yml`) →
  path **`/admin/config/system/address_static_map`**, `_form: \Drupal\address_static_map\Form\SettingsForm`,
  `_permission: 'administer site configuration'`.
- Menu link `address_static_map.settings` (`address_static_map.links.menu.yml`) under
  `system.admin_config_system` (*Configuration → System*).
- `SettingsForm` extends core `ConfigFormBase`; it is a normal config form (CSRF-protected,
  admin-gated). Editable config: **`address_static_map.settings`**.

## Config object `address_static_map.settings`

Install defaults (`config/install/address_static_map.settings.yml`):

```yaml
premier: 0
api_key: ''
premium_client_id: ''
icon_url: ''
```

Keys written by `SettingsForm::submitForm()`:

| Key | Type | Set when | Meaning |
|---|---|---|---|
| `premier` | bool (0/1) | always | Use Google Maps Premier (Premium Plan) instead of a standard API key. |
| `api_key` | string | `premier` = 0 | Standard Google Static Maps API key. Stored **as plain config**. Emitted as `key=` in the map URL. |
| `secret_key_id` | string (Key id) | `premier` = 0 | Id of a **Key** entity holding the URL-signing secret. |
| `premium_client_id` | string | `premier` = 1 | Google Premium client ID. Stored **as plain config**. Emitted as `client=` in the map URL. |
| `premium_crypto_key_id` | string (Key id) | `premier` = 1 | Id of a **Key** entity holding the premium crypto key. |
| `icon_url` | string | always | Optional custom marker icon URL (must be < 64x64 per Google). Empty → marker `color:green`. |

Note: `secret_key_id` and `premium_crypto_key_id` are **not** in the install config or
`config/schema/address_static_map.schema.yml` (the schema file only declares the *formatter*
settings mapping `field.formatter.settings.address_static_map`, not `address_static_map.settings`).
They are saved to the config object at runtime.

## The two credential modes

`SettingsForm::buildForm()` loads all `Key::loadMultiple()` entities into the two select lists and
uses `#states` so the standard fields (API key + signing secret) show when *Premier* is unchecked,
and the premier fields (client ID + crypto key) show when it is checked. Both key selects link to
`entity.key.add_form` to create a new Key.

- **Standard**: `api_key` (plain) + `secret_key_id` (Key). `MapRenderer` adds `key=<api_key>` and
  signs with the `secret_key_id` Key.
- **Premier**: `premium_client_id` (plain) + `premium_crypto_key_id` (Key). `MapRenderer` adds
  `client=<premium_client_id>` and signs with the `premium_crypto_key_id` Key.

## Signing (MapSigner)

`Service\MapSigner::generateSignature($key_id, $data)` (service `address_static_map.map_signer`,
constructed with `@key.repository`): loads the Key entity by id, `base64_decode`s the URL-safe
secret (`strtr($value, '-_', '+/')`), computes `hash_hmac('sha1', $data, $secret, TRUE)`, and
returns URL-safe base64 (`strtr(base64_encode(...), '+/', '-_')`). The signing secret / crypto key
themselves are **never placed in the map URL** — only the resulting signature is. Empty/missing key
id → empty signature (unsigned URL).

## Operating notes

- The signing secret and premium crypto key are correctly kept in **Key** entities (env/file/config
  providers per your Key setup), so they can stay out of exported config.
- Get a Google Static Maps API key and (recommended) a URL-signing secret from the Google Cloud
  console; restrict the key by HTTP referrer since it travels in the client-visible image URL.
