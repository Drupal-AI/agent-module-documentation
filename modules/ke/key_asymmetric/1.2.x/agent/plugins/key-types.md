<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two Key Type plugins

Both are `@KeyType` plugins extending `Drupal\key\Plugin\KeyTypeBase` and implementing
`KeyPluginFormInterface`, with `key_value.plugin = textarea_field`.

| Plugin id | Class | Label | group |
|---|---|---|---|
| `asymmetric_private` | `AsymmetricPrivateKeyType` | Private key | `asymmetric_private` |
| `asymmetric_public` | `AsymmetricPublicKeyType` | Public key/certificate | `asymmetric_public` |

## Form settings

Private key form adds: **Skip key validation** (`skip_validation`, accept any value, store no
metadata), **Private key passphrase** (`passphrase`, validation-only, never stored), and an
**Info** button (shows detected properties without saving). Public key form adds a `key_select`
**Private key** field (`private_key`) filtered to `type => asymmetric_private` — the one
UI-editable setting — plus the same Skip validation / Info controls.

## Stored metadata (key_type_settings)

On a successful validate/save, phpseclib-extracted metadata is written into the key's
`key_type_settings` (config schema `key.type.asymmetric_private` / `key.type.asymmetric_public`):

- **private**: `has_public` (bool), `format`, `algo`, `key_size`, `hash_algo`, `hash_size`.
- **public**: `format`, `algo`, `key_size`, `hash_algo`, `hash_size`, `fingerprint`,
  `cert` (`subject`, `issuer`, `not_before`, `not_after`) for X.509, and `private_key` (the ref).

`generateKeyValue()` throws `KeyException` — you cannot create new key material through these
types; you provide existing keys. Values are stored as-is (no reformatting).

## Create a Key entity programmatically

Keys are core Key module `key` config entities (config `key.key.<id>`). Example private key with
the `config` provider (value stored in config; use the `file`/`env` provider for real secrets):

```php
use Drupal\key\Entity\Key;
Key::create([
  'id' => 'my_private',
  'label' => 'My private key',
  'key_type' => 'asymmetric_private',
  'key_type_settings' => [],
  'key_provider' => 'config',
  'key_provider_settings' => ['key_value' => $pem_string],
  'key_input' => 'textarea_field',
  'key_input_settings' => [],
])->save();
```

A public key/cert referencing it:

```php
Key::create([
  'id' => 'my_public',
  'label' => 'My public key',
  'key_type' => 'asymmetric_public',
  'key_type_settings' => ['private_key' => 'my_private'],   // the key-pair link
  'key_provider' => 'config',
  'key_provider_settings' => ['key_value' => $public_pem],
  'key_input' => 'textarea_field',
])->save();
```

Programmatic `save()` does not run the form's `validateKeyValue()`, so metadata is only
auto-populated through the admin form (or set it yourself / call the KeyPair service). Via the UI:
*Configuration → System → Keys → Add key*, choose Key type **Private key** or **Public
key/certificate**, paste the value, optionally press **Info**, then **Save**.

## Read a key back

```bash
drush config:get key.key.my_public          # shows key_type + key_type_settings.private_key
```

```php
$key = \Drupal::service('key.repository')->getKey('my_private');
$pem = $key->getKeyValue();                                   // the raw key material
$meta = $key->getKeyType()->getConfiguration();               // format, algo, key_size, ...
```
