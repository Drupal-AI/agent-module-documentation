# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Toolbar Menu** module (`toolbar_menu`) — this is a hard
  dependency, and it in turn relies on core's Toolbar module. Composer pulls it
  in automatically.

There are no PHP library or third‑party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/default_toolbar_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Toolbar Menu dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/default_toolbar_menu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_toolbar_menu -y
```

This also enables the `toolbar_menu` dependency if it is not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → User interface → Default
Toolbar Menu** (`/admin/config/user-interface/toolbar_menu/setting`). If the
form loads and lists your roles, the module is active. Before the mapping does
anything visible you will need at least one Toolbar Menu entry to assign — see
[Configuration](../configuration/index.md).
