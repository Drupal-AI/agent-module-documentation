# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`), which provides the
  editable menu links Flat Menus constrains.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flat_menus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flat_menus -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flat_menus -y
```

This also enables the Menu Link Content module if it isn't already on.

## Grant the permission

Flat Menus adds an **Enable flat menu option** permission that controls who can
mark a menu as flat. At **People → Permissions** (`/admin/people/permissions`),
grant it to the administrator or site‑builder role that manages menus.

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`) and edit a menu. As a user
with the permission, you should now see a **Flat menu** checkbox on the menu's edit
form. See [Configuration](../configuration/index.md) for what happens when you tick
it.
