# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).

The module has no dependencies outside Drupal core and no third‑party Composer or
PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/expired_reset_pass_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expired_reset_pass_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expired_reset_pass_link -y
```

## Verify it worked

Go to **Configuration → People → Account settings**
(`/admin/config/people/accounts`). You should see a new setting for the
**password‑reset link timeout**. See [Configuration](../configuration/index.md) for
how to set it.
