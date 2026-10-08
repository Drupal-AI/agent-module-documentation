# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Encrypt** module (`drupal/encrypt` `^3.0`) — Real AES is an encryption
  *method* plugin for Encrypt and cannot work without it.
- The **`defuse/php-encryption`** Composer library (`^2.0`) — this does the
  actual cryptography. Composer installs it for you (see below); if it's ever
  missing, Real AES's requirements check will flag it.
- In practice you'll also want the [Key](https://www.drupal.org/project/key)
  module to hold the 256‑bit encryption key.

## Install with Composer

From the project root:

```bash
composer require drupal/real_aes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Encrypt
module and the `defuse/php-encryption` library along with it. To grab the Key
module in the same step:

```bash
composer require drupal/real_aes drupal/key -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/real_aes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Real AES together with Encrypt and Key:

```bash
drush en real_aes encrypt key -y
```

There is no Real AES settings form. From here, follow the steps in the
[overview](../index.md#how-to-use-it) to create a key and an encryption profile
that uses the *Authenticated AES (Real AES)* method.

## Submodules

Real AES ships no submodules.
