# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Media Library** module (`media_library`) enabled — this is the only dependency, and
  Drupal enables it (and its own dependency, Media) automatically when you turn on Media Library
  Extend.

There are no third‑party Composer or PHP library requirements. On its own the module is only
useful for prototyping (see the example plugins in [Configuration](../configuration/index.md));
a real integration means writing a custom source plugin or adding a contrib one.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_extend -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/media_library_extend -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_extend -y
```

Enabling it also enables core Media Library if it is not already on. Nothing changes in the
editor experience yet — you have to create at least one pane before an extra tab appears (see
[Configuration](../configuration/index.md)).

There are no submodules.
