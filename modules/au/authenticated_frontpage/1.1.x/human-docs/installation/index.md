# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies and no third-party Composer or PHP library requirements are
  declared — it needs only core.

## Install with Composer

From the project root:

```bash
composer require drupal/authenticated_frontpage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/authenticated_frontpage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en authenticated_frontpage -y
```

## Next steps

Grant the **`administer authenticated_frontpage configuration`** permission to trusted
administrators, then set the alternative front page on the settings form — see
[Configuration](../configuration/index.md).
