# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The core **Content Translation** module (`content_translation`) enabled — this
  module operates on translated content, so it depends on it.
- Translatable entity-reference fields whose translations you need to repair (that's
  the situation this module exists to fix).

## Install with Composer

From the project root:

```bash
composer require drupal/ereftras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ereftras -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ereftras -y
```

Make sure the core **Content Translation** module is enabled too:

```bash
drush en content_translation -y
```

## Verify it worked

Visit **Configuration → Development → Entity Reference Field Translation
Synchronize** (`/admin/config/development/ereftras`) — the bulk synchronize form
should load with selectors for the entity type, bundle and fields. You should also
see a new **synchronize** option appear in the settings of translatable
entity-reference fields. See [Configuration](../configuration/index.md) for how to
run a synchronization.
