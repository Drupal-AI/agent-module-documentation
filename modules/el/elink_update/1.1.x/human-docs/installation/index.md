# Installation

## Requirements

- **Drupal 8.8.3, 9, or 10** (`core_version_requirement: ^8.8.3 || ^9 || ^10`).

There are no module dependencies and no external libraries.

> **Note:** This project's security advisory coverage is marked *not covered* by
> the Drupal Security Team. The tool rewrites stored content in bulk, so take a
> database backup before running it on production.

## Install with Composer

From the project root:

```bash
composer require drupal/elink_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elink_update -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elink_update -y
```

## Verify it worked

Go to **Configuration → External Link Update** (`/admin/config/elink-update`). The
update form should load, listing your content types as checkboxes along with the
target and rel options. From here you can run the update — see
[Configuration](../configuration/index.md).
