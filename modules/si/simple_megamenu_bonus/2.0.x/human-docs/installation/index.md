# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Simple Megamenu** module (`simple_megamenu`) — this is a required parent
  module; Simple megamenu bonus extends it and does nothing without it. Read Simple
  Megamenu's own documentation as well.
- No additional PHP libraries or third‑party Composer packages.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_megamenu_bonus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Simple Megamenu is not already present, install it too:

```bash
composer require drupal/simple_megamenu drupal/simple_megamenu_bonus -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_megamenu_bonus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en simple_megamenu simple_megamenu_bonus -y
```

## After enabling

This module needs a manual template step to take effect: copy
`simple_megamenu_bonus/templates/menu--simple-megamenu.html.twig` into your theme's
`templates` directory and clear caches. Then configure your mega‑menu types, field
displays, and view modes — the full walkthrough is in
[How to use it](../index.md#how-to-use-it).

## Verify it worked

Once both modules are enabled and the template is copied, editing a mega‑menu item
should offer a **view mode selector**, and your mega‑menu type's display should show a
movable **"Submenu (menu items below)"** field. If those appear, the enhancement is
active.
