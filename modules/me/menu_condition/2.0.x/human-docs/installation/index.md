# Installation

## Requirements

Menu Condition is self-contained:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). Version 2.0.x
  dropped support for Drupal 8 and 9 — if you are still on those, use the 1.x
  branch instead.
- No third-party Composer or PHP library requirements, and no other contrib
  modules. It builds on core's condition and menu systems, which are always
  present.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_condition -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_condition -y
```

That is all. There is no configuration form — the new **Menu position** condition
becomes available immediately in every block's visibility settings.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), configure any
block, and open its **Visibility** section. You should see a **Menu position**
tab. See the [overview](../index.md#how-to-use-it) for how to use it.
