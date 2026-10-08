# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Path alias** module (`path_alias`) — this is the only dependency, and
  Drupal enables it automatically when you turn on NG Lightbox. It is what lets
  the module match links against their URL aliases as well as their internal
  paths.

There are no third‑party Composer or PHP library requirements, and NG Lightbox
adds no JavaScript of its own — it relies entirely on core's AJAX dialog system.

## Install with Composer

From the project root:

```bash
composer require drupal/ng_lightbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ng_lightbox -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ng_lightbox -y
```

Once enabled the module is installed but **inactive** until you add at least one
path pattern — the default pattern list is empty, so nothing is lightboxed yet.
Head to [Configuration](../configuration/index.md) to add your paths.

NG Lightbox has no submodules.
