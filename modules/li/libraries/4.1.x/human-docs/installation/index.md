# Installation

## Requirements

Libraries depends only on Drupal core:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required, and there are no submodules.

Note that Libraries itself does not ship the external libraries you want to use — it
is the mechanism for discovering, locating, and loading them. You still place each
external library on disk (typically in the site‑wide `libraries` directory) or point
Libraries at a definition registry.

## Install with Composer

From the project root:

```bash
composer require drupal/libraries -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/libraries -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en libraries -y
```

Libraries has no configuration form and no permissions to grant. Once enabled, its
`libraries.manager` service and plugin system are available for other modules and
themes to use, and you can run `drush libraries-list` to see which libraries are
currently registered. For how to consume it, see the
[overview](../index.md#how-to-use-it) and the sibling
[`agent/`](../agent/start.md) docs.
