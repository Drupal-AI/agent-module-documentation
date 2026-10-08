# Installation

## Requirements

Node Access Rebuild Progressive needs:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **PHP 5.6 or newer** (`php: >=5.6.0`) — any supported modern Drupal already
  exceeds this comfortably.
- The `consolidation/site-alias` Composer library, which the module declares as a
  requirement; Composer pulls it in for you.

It has no module dependencies. It is most useful on sites that use a node-access
module (Group, Domain Access, Workbench Access, and similar).

## Install with Composer

From the project root:

```bash
composer require drupal/node_access_rebuild_progressive -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including `consolidation/site-alias`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_access_rebuild_progressive -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_access_rebuild_progressive -y
```

Once enabled, the module immediately takes over the rebuild path: core's "Rebuild
permissions" form is disabled, the Drush command becomes available, and the settings
page appears under *Configuration → Development*.

## Next steps

See [Configuration](../configuration/index.md) to tune the chunk size, optionally
enable cron-based processing, and run a rebuild.
