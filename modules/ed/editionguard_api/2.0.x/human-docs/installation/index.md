# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **EditionGuard account with API access** (a subscription). Without valid
  EditionGuard credentials the client has nothing to authenticate against.

There are no other Drupal module dependencies, no PHP library requirements
declared, and no third‑party front-end libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/editionguard_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/editionguard_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editionguard_api -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services →
EditionGuard API** (`/admin/config/services/editionguard-api`). If the settings
form loads, the module is installed. Nothing happens until you enter your
EditionGuard credentials — see [Configuration](../configuration/index.md) — and
call the client from your own code.
