# Easy Encryption — manual setup guide

**Easy Encryption** (`easy_encryption`) provides **at-rest encryption for
sensitive credentials** — API keys, passwords, tokens — with essentially no
configuration. It builds on the popular **Key** module and adds a new key
provider called *Easy Encrypted*. When you install it, the module automatically
generates a libsodium key pair for your site, so secrets are stored as ciphertext
that's safe to export in configuration rather than as readable plaintext.

The headline feature is that it's secure by default. Not only does it add an
encrypted storage option — it actively protects you from mistakes: if you (or
another module) try to create a Key using an insecure provider such as *Config*
or *State*, Easy Encryption transparently upgrades it to the encrypted provider
before anything is written, so plaintext secrets never land in your database or
exported config.

The encryption uses a two-part key pair: a *public* key (used to encrypt, safe to
export) and a *private* key (used to decrypt), which is stored outside the web
root in a protected file and must never be committed to version control. The
module ships Drush commands for key rotation and moving the private key to the
filesystem, and an optional admin submodule that adds a UI for exporting,
importing, and migrating keys.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (with Key and the sodium library) and enable it.

## Where it lives in the admin menu

The base module has **no settings page** — encryption works as soon as it's
installed. You create encrypted secrets on the standard Key screens under
**Configuration → System → Keys** (`/admin/config/system/keys`). The optional
**Easy Encryption Admin** submodule adds key export/import and private-key
migration pages there too.

## How to use it

**Encrypt a credential.** Go to **Configuration → System → Keys → Add key**. The
**Key provider** is pre-selected to **Easy Encrypted**, and a note explains the
auto-upgrade behavior. Enter your key type, paste the secret value, and save —
the value is stored as encrypted hex ciphertext. Your code then reads it back
through the normal Key API, decrypted transparently:

```php
$key = \Drupal::service('key.repository')->getKey('my_api_key');
$plaintext = $key->getKeyValue();
```

**Let it protect you automatically.** Any *new* Key created with an insecure
provider (Config or State) is upgraded to Easy Encrypted before saving. You can
control which providers get upgraded — or disable the behavior — in
`settings.php`:

```php
// Default — upgrade these insecure providers to encrypted:
$settings['easy_encryption']['upgraded_key_providers'] = ['config', 'state'];
// Disable auto-upgrades entirely:
$settings['easy_encryption']['upgraded_key_providers'] = [];
```

**Know where the private key lives.** By default the private key is stored in a
protected `.easy_encryption` directory next to your web root (files locked down,
never web-served). **Do not commit it.** You can point it elsewhere:

```php
$settings['easy_encryption']['private_key_directory'] = '/secure/path';
```

If the module ever has to fall back to storing the private key in the database,
the Status report warns you — move it back to the filesystem with the Drush
command below.

**Rotate keys and manage storage (Drush).**

```bash
# Preview a key rotation and how many credentials would be re-encrypted:
drush easy-encryption:rotate --dry-run --reencrypt

# Rotate the active key and re-encrypt existing secrets (asks to confirm):
drush easy-encryption:rotate --reencrypt

# Check whether the private key needs moving from the database to the filesystem:
drush easy-encryption:migrate-private-key --check

# Move it to the filesystem:
drush easy-encryption:migrate-private-key
```

(These commands require Drush 13.7 or newer.)

**Safety rails.** The module blocks deleting the Key entities of an active or
in-use key pair, and won't let you uninstall while encrypted keys still exist —
it clears and prunes keys during uninstall instead.
