# Installation

## Requirements

- **Drupal 9.5, 10.2+, or 11**
  (`core_version_requirement: ^9.5 || ^10.2 || ^11.0`).

There are no third-party Composer, PHP library, or Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_theme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/admin_theme -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_theme -y
```

There are no submodules. Out of the box the Include and Exclude lists carry a
placeholder value that matches nothing (a workaround for a core bug), so nothing
changes until you set real paths — see [Configuration](../configuration/index.md).

## Verify it worked

Go to **Appearance** (`/admin/appearance`) and confirm that **Include** and
**Exclude** fields now appear on the page. Enter a test path in Include, save,
visit that path, and check the admin theme is applied.
