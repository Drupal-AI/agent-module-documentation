# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/access_by_ref -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/access_by_ref -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_by_ref -y
```

## After enabling

1. Grant the **Administer access_by_ref settings** permission (trusted admins) and
   the **Access node by reference** permission (the roles that should *gain*
   reference-based access) under **People → Permissions**.
2. Create your rules at **Configuration → Content authoring → Access by Reference**
   — see [Configuration](../configuration/index.md).

### Migrating from Drupal 7

The module ships a Drupal 7 migration (`d7_access_by_ref`) that imports legacy
Access by Reference configuration if you are upgrading an older site.
