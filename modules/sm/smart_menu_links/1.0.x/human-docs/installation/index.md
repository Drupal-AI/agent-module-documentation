# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Pathauto** (`drupal/pathauto`) — the module's own documentation states it
  requires Pathauto; otherwise it relies only on Drupal core.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_menu_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Pathauto is not already present, add it too:

```bash
composer require drupal/pathauto -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_menu_links -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_menu_links -y
```

Enable Pathauto as well if it is not already on (`drush en pathauto -y`).

## Verify it worked

After enabling, clear caches (`drush cr`) and look under the **Structure** menu for
the Smart Menu Links administration page. A cache clear is worth doing here because
newly added smart links sometimes need one before they show up. Then continue to
[Configuration](../configuration/index.md).
