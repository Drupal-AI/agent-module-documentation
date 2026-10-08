# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Toolbar Menu** module (`toolbar_menu`) — this is a required dependency and the module
  it complements. (Toolbar Menu in turn builds on core's Toolbar module.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/toolbar_menu_clean -W
```

Toolbar Menu Clean depends on Toolbar Menu, so pull that in too if it is not already present:

```bash
composer require drupal/toolbar_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/toolbar_menu_clean -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toolbar_menu_clean -y
```

Drupal enables Toolbar Menu automatically as a dependency.

## Important: it takes effect immediately

As soon as it is enabled, the module starts hiding toolbar elements for any role that does
**not** hold its three permissions — including, potentially, roles you did not intend. Before
or right after enabling, go to [Configuration](../configuration/index.md) and grant the
permissions to the roles that should keep the standard toolbar (typically administrators),
so you don't lose the Manage tray for yourself.
