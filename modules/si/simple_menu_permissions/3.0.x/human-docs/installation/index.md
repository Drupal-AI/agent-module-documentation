# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Menu UI** (`menu_ui`) and **Menu Link Content** (`menu_link_content`)
  modules — Drupal enables these automatically as dependencies.

There are no third‑party Composer packages or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_menu_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_menu_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_menu_permissions -y
```

As soon as it is enabled, the per‑menu permissions appear on **People →
Permissions** for every menu on the site, plus the global **Create new menu**
permission. Assign them as described in [Configuration](../configuration/index.md).

There are no submodules.
