# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement:
  ^8.7.7||^9||^10||^11`).
- The **jsTree** JavaScript library — the module integrates it but does not bundle
  it, so you must install it separately (see below).
- Recommended: the **jsTree proton theme** for the nicer tree styling, and a
  Bootstrap theme / Bootstrap library module or the **Font Awesome** module so the
  menu icons render correctly.

## Install with Composer

From the project root:

```bash
composer require drupal/jstree_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jstree_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the jsTree library

The module needs the jsTree library present to render anything. Follow the
instructions in the **module's README** to place the jsTree library (and, if you
want it, the proton theme) where Drupal can load it. Without this step the block
has nothing to draw the tree with.

## Enable the module

```bash
drush en jstree_menu -y
```

## Verify it worked

After enabling, a new **jsTree menu** block type is available under **Structure →
Block layout** (`/admin/structure/block`). Place it, pick a menu, and load the
page — the menu should render as an interactive, collapsible tree. If it renders
as a plain list or not at all, re-check the jsTree library installation. Then see
[Configuration](../configuration/index.md).
