# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) — the only dependency, enabled
  automatically when you turn on Nice Menus.

There are no third‑party Composer or PHP library requirements: the Superfish and hoverIntent
JavaScript libraries ship with the module (nothing is loaded from a CDN).

## Install with Composer

From the project root:

```bash
composer require drupal/nice_menus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/nice_menus -W`, `ddev drush …`. Inside the container (`ddev ssh`)
> run them without the prefix.

## Enable the module

```bash
drush en nice_menus -y
```

Enabling it also enables **Menu Link Content** if it is not already on.

## Grant the permission

The module adds one permission, **`manage nice menu settings`**, at **People → Permissions**. It
gates the global settings form only (which toggles JavaScript/CSS loading and hover timing) — it
is not marked *restrict access*. Placing and configuring the menu blocks themselves is done
through Block layout, governed by core's block administration permissions.

## Next steps

Nothing renders until you place a **Nice Menus** block via **Structure → Block layout** — see
[Configuration](../configuration/index.md).

There are no submodules.
