# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **History**, **Views** and **Menu UI** modules. Views and Menu UI ship
  with core; Drupal enables them as dependencies when you turn this module on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/badge_notification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/badge_notification -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en badge_notification -y
```

After enabling, grant the module's permission to the roles that should see the
badges, then connect a menu item to a View that produces the count you want to
display (see [How to use it](../index.md#how-to-use-it)).
