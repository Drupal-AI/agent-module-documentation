# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Menu** and **Block** systems, which are part of a standard Drupal
  install — Superfish renders existing menus into block form.
- One external front-end library, **`lobsterr/drupal-superfish`** (pinned to
  `2.3.10`), which supplies the Superfish jQuery plugin's JavaScript and CSS.
  Composer installs it for you (see below).

There are no other module dependencies and no special PHP version requirement
beyond what your Drupal core already needs.

## Install with Composer

From the project root:

```bash
composer require drupal/superfish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the `lobsterr/drupal-superfish` library
automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/superfish -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en superfish -y
```

Enabling the module makes the **Superfish** block type available, but it does not
place anything on your site by itself — nothing changes until you place and
configure a Superfish block.

## Next step

Head to [Configuration](../configuration/index.md) to place your first Superfish
block and turn a menu into a drop-down navbar or fly-out sidebar.
