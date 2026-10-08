# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Encrypt** module (`drupal/encrypt`) — provides the encryption framework
  this module plugs into.
- The **Key Asymmetric** module (`drupal/key_asymmetric`) — manages the RSA
  public/private key pairs.
- The **phpseclib** crypto library, pulled in through Composer.

> **Heads up:** this version is a beta release and is not covered by Drupal's
> security advisory policy. Weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/encrypt_rsa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Encrypt, Key
Asymmetric, and phpseclib dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/encrypt_rsa -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en encrypt_rsa -y
```

This also enables Encrypt and Key Asymmetric if they are not already on.

## Verify it worked

Confirm `encrypt_rsa`, `encrypt`, and `key_asymmetric` are enabled on the
**Extend** page (`/admin/modules`). Then check that the RSA encryption methods
(such as *Public OpenSSL Seal*) appear when you create an Encryption Profile.
From there, follow the setup flow in the [main guide](../index.md#how-to-use-it).
