# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules are required. Menu Position builds on core's menu
  system and core condition plugins.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_position -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_position -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_position -y
```

## Grant the permission

Managing rules is gated behind the module's own permission. Grant it to the roles
that should create menu-position rules — this lets them manage menu placement
*without* also granting full menu administration:

```bash
drush role:perm:add editor 'administer menu positions'
```

The **Settings** page (the global display mode) is instead gated by core's
**Administer site configuration** permission, which administrators already have.

## Verify it worked

Log in as a user with **Administer menu position rules** and go to **Structure →
Menu position rules** (`/admin/structure/menu-position`). You should see the
(initially empty) rules list with an **Add rule** button. Head to
[Configuration](../configuration/index.md) to create your first rule.
