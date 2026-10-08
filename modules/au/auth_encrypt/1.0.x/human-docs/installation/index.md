# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third-party Composer or PHP library requirements are
  declared.

Note that the current release is an early **beta** (1.0.0-beta2). Review the module's
algorithm and key handling before relying on it for sensitive credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/auth_encrypt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auth_encrypt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auth_encrypt -y
```

## Next steps

There is no settings page. The important setup work is key management — see
[How to use it](../index.md#how-to-use-it) for keeping the encryption key out of the
codebase and database, rotating it, and never logging it.
