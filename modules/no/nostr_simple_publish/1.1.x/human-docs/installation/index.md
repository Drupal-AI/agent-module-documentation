# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1+** with the **GMP** extension enabled
  (`https://www.php.net/manual/en/ref.gmp.php`) — required for signing Nostr
  events.
- A **Nostr key pair** (public and private key) and at least one relay. The keys
  are supplied via `settings.php` (see [Configuration](../configuration/index.md)).

This is an alpha release and currently works for a **single Drupal user**.

## Install with Composer

From the project root:

```bash
composer require drupal/nostr_simple_publish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nostr_simple_publish -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. To confirm the GMP
> extension is present in the container, run `ddev exec 'php -m | grep -i gmp'`.

## Enable the module

```bash
drush en nostr_simple_publish -y
```

## Verify it worked

Confirm the module is enabled and that PHP reports the **GMP** extension. The module
won't publish anything until you add the key/relay settings and grant the *publish
to nostr network* permission — continue to
[Configuration](../configuration/index.md). Once configured, you'll see a **"Publish
to Nostr"** fieldset on the node edit form for users who hold that permission.
