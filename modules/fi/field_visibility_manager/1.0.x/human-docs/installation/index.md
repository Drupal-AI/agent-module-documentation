# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library dependencies.

Note that the module acts on **node** entity forms and on fields whose machine
names start with `field_`.

## Install with Composer

From the project root:

```bash
composer require drupal/field_visibility_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_visibility_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_visibility_manager -y
```

## Verify it worked

Log in as an administrator and visit
`/admin/config/field_visibility_manager/adminsettings`. You should see a table
listing your node fields as rows and your roles as columns. Configure it as
described in [Configuration](../configuration/index.md).
