# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Breakpoint** and **System** modules (enabled automatically as
  dependencies).
- The **mmenu** JavaScript library (8.x) — *required*. The off-canvas menu will
  not render without it.
- The **Superfish** JavaScript library — *optional*, only needed if you want
  Superfish hover/flyout enhancement on the horizontal menu.

There are no PHP library or third-party Composer requirements beyond the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_menu -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the mmenu library

This step is required — do not skip it.

1. Download the **mmenu 8.x** library, or run `npm install` inside the module
   directory to fetch it.
2. Place it so that the built files live at **`/libraries/mmenu/dist`** in your
   docroot.

If mmenu is missing, the burger toggle will not open anything.

### Optional: Superfish

If you plan to use the Superfish enhancement on the horizontal menu, download the
Superfish library to **`/libraries/superfish`**.

## Enable the module

```bash
drush en responsive_menu -y
```

After enabling, continue to [Configuration](../configuration/index.md) to choose
your menus and breakpoint, and to place the two blocks — nothing appears on the
page until the blocks are placed.
