# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- **Blazy 3.x** (`drupal/blazy:^3.0`) — a shared vanilla-JS base library. This is a
  Composer requirement, so Composer pulls it in for you.
- Core's **Block** (`block`) and **Menu** modules, both declared as dependencies
  and enabled automatically.

There is no PHP version requirement beyond what Blazy and core need.

## Install with Composer

From the project root:

```bash
composer require drupal/ultimenu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Blazy and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ultimenu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ultimenu -y
```

This also enables Blazy, Block, and Menu if they are not already on.

Note that the module ships **no default configuration** — the `ultimenu.settings`
object doesn't exist until you save the settings form once. So after enabling,
head to **Structure → Ultimenu** and work through
[Configuration](../configuration/index.md) to turn a menu into a mega-menu.

There are no submodules.
