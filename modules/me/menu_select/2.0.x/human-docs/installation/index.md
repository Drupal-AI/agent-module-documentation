# Installation

## Requirements

Menu Select is a small, core‑only module:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Menu UI** module (`menu_ui`), enabled — it is the only dependency and
  provides the parent‑item selector that Menu Select improves.

There are no third‑party Composer packages or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_select -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_select -y
```

This also enables **Menu UI** if it isn't already on. Or enable **Menu Select** from
**Extend** (`/admin/modules`).

There are no submodules.

## Next steps

The tree‑based parent picker is active as soon as the module is enabled — open any menu
link edit form or a node's "Menu settings" and you'll see it. To turn the autocomplete
search box on or off and grant its permission, see
[Configuration](../configuration/index.md).
