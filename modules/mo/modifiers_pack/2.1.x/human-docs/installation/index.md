# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The base **[Modifiers](https://www.drupal.org/project/modifiers)** module
  (`modifiers`) — Modifiers Pack depends on it.

Each individual modifier submodule may have its own additional requirements or
dependencies (for example a media-related modifier). Check that submodule's own
README/info file before enabling it. There are no third‑party Composer or PHP
library requirements for the pack itself.

## Install with Composer

From the project root:

```bash
composer require drupal/modifiers_pack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the base `modifiers` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/modifiers_pack -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base pack, then enable the specific modifier plugins you want:

```bash
drush en modifiers_pack -y
```

## Submodules — enable only what you need

Modifiers Pack ships each modifier as its own submodule, so you enable just the
styling controls you want to expose. Available modifiers include: Absolute
Height, Relative Height, HTML Font Size, Colors, Custom Colors, Fonts, Corners,
Padding, Shadow, Image Background, Video Background, Parallax Background, Image
FX, Linear Gradient, Radial Gradient, Custom Linear Gradient, Custom Radial
Gradient, and Hide.

Enable an individual modifier with `drush en`, for example:

```bash
drush en modifiers_padding -y
```

Enable only what your design system needs — a smaller set keeps the editor's
palette focused. Check each submodule's info file for any extra dependencies.

## Verify it worked

Go to **Extend** (`/admin/modules`) and confirm the Modifiers Pack submodules
appear and that the ones you enabled are active. Then attach a modifiers field to
a component and confirm the enabled modifiers show up as options. See the
[main guide](../index.md) for how to use them.
