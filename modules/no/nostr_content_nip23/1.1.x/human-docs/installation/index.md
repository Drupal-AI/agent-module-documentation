# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1+** with the **GMP** extension enabled
  (`https://www.php.net/manual/en/ref.gmp.php`) — required for the elliptic‑curve
  cryptography used to sign Nostr events.
- A **Nostr key pair** (public and private key) and at least one relay to publish
  to. Keep the private key secret (see the
  [overview](../index.md#signing-key-and-relays)).

This is an alpha release and currently works for a **single Drupal user**.

## Install with Composer

From the project root:

```bash
composer require drupal/nostr_content_nip23 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nostr_content_nip23 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. To check the GMP
> extension is present in the container, run `ddev exec 'php -m | grep -i gmp'`.

## Enable the module

```bash
drush en nostr_content_nip23 -y
```

## Verify it worked

Confirm the module is enabled (`drush pm:list --status=enabled | grep nostr` or the
**Extend** page) and that PHP reports the **GMP** extension. Then provide your
signing key as described in the [overview](../index.md#signing-key-and-relays)
before attempting to publish. Because this is an early alpha, test against a relay
you control or don't mind experimenting with first.
