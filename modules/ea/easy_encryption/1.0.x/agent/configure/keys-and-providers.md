<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Keys & the `easy_encrypted` provider

No settings form in the base module — encryption "just works" after install. Configuration is via
Key entities and `settings.php`.

## What install creates

`hook_install()` (and the `ensureEasyEncryptionSetup` config action, for recipes) generates and
activates a libsodium key pair:

- Config `easy_encryption.keys`:
  - `active_encryption_key_id` — the active encryption key id (e.g. `5ae71658_93d2_4ceb_…`).
  - `encryption_keys` — sequence of `{ encryption_key_id }` known to the site.
- Two **Key entities** per pair:
  - `easy_encrypted__<id>__public_key` — Key provider `config`; used to **encrypt** (safe to export).
  - `easy_encrypted__<id>__private_key` — Key provider `file` (decorated); used to **decrypt**.

Read it: `drush cget easy_encryption.keys`.

## Encrypting a credential

Create a Key entity using the **Easy Encrypted** provider (`easy_encrypted`). The value is encrypted
and stored as hex ciphertext plus the `encryption_key_id` in the key's `key_provider_settings`
(schema `key.provider.easy_encrypted`). Use it like any Key:

```php
$key = \Drupal::service('key.repository')->getKey('my_api_key');
$plaintext = $key->getKeyValue();   // decrypted (needs the private key)
```

Scriptable creation:

```php
$key = \Drupal\key\Entity\Key::create([
  'id' => 'my_api_key', 'label' => 'My API key',
  'key_type' => 'authentication',
  'key_provider' => 'easy_encrypted',
  'key_provider_settings' => [],
  'key_input' => 'text_field',
]);
$key->setKeyValue('super-secret');   // setKeyValue() is not fluent — call it, then save()
$key->save();
```

## Transparent auto-upgrade (security by default)

`hook_key_presave` (`KeyEntityHooks::onKeyPreSave`): when a **new** Key uses an insecure provider it
is upgraded to `easy_encrypted` before saving, so plaintext is never written. The upgradable
providers default to `['config', 'state']`:

```php
// settings.php
$settings['easy_encryption']['upgraded_key_providers'] = ['config', 'state']; // default
$settings['easy_encryption']['upgraded_key_providers'] = [];                   // disable upgrades
```

`easy_encrypted` is also pre-selected on the key **add** form (`hook_key_prepare_form`), and a
warning explains the auto-upgrade (`form_key_add_form_alter`).

## Private key storage

- Default: a `.easy_encryption` directory next to the web root, files `0600`, PHP-wrapped (no output
  if web-exposed). **Do not commit it.** Falls back to Drupal State if the filesystem fails.
- Change location: `$settings['easy_encryption']['private_key_directory'] = '/secure/path';`
- Move DB→filesystem: `drush easy-encryption:migrate-private-key` (see
  [../drush/commands.md](../drush/commands.md)).

## Protections

- `key_access` hook forbids deleting the Key entities of an active or still-in-use key pair.
- An uninstall validator blocks uninstalling while encrypted keys exist; `module_preuninstall`
  clears the active key and prunes remaining pairs.
- `hook_requirements` runs a self-test and warns (Status report) if the private key is stored in the
  database/State.
