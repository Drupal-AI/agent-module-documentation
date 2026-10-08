# Installation

## Requirements

Sodium has firmer requirements than most modules because it wraps a real crypto
library:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or newer** (`php: >=8.3`).
- The **libsodium PHP extension** enabled. Check with `php -m | grep -i sodium`;
  it should list `sodium`.
- **ParagonIE Halite** (`paragonie/halite ^5.1`) — the PHP crypto library that
  does the actual encryption. Composer pulls this in for you.
- The **Key** module (`drupal/key ^1.0`) — for storing the encryption key.
- The **Encrypt** module (`drupal/encrypt ^3.2`) — Sodium is a plugin *for*
  Encrypt, so this is a hard dependency.

If Halite is not present, the module refuses to install: its install‑time
requirements check fails with *"Sodium requires the Halite PHP library."* That's
a Composer/environment problem to fix, not a Drupal one.

## Install with Composer

From the project root:

```bash
composer require drupal/sodium -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This one command also pulls in Halite, the Key module,
and the Encrypt module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sodium -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV ships the
> libsodium extension by default.

## Enable the module

```bash
drush en sodium -y
```

Drupal will also enable the Key and Encrypt modules if they aren't already on. If
enabling fails at the requirements check, confirm Halite is installed
(`composer show paragonie/halite`) and that the libsodium PHP extension is
loaded.

## Next steps

There is no configuration form for Sodium itself. To actually use it, create an
Encryption key with the Key module and an encryption profile with the Encrypt
module, choosing **Sodium** as the method — the steps are summarized under
[How to use it](../index.md#how-to-use-it) on the overview page, and the agent
doc [`configure/setup.md`](../../agent/configure/setup.md) has ready‑to‑run
commands for generating the 32‑byte key and building and testing the profile.
