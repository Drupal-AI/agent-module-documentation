# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules and no PHP or Composer libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/entitytype_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entitytype_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entitytype_filter -y
```

## Verify it worked

Log in as an administrator and go to **`/admin/entitytypes-filter`**. You should
see the **Entity Fields Search** page with its filters. See
[Configuration](../configuration/index.md) for how to use it.
