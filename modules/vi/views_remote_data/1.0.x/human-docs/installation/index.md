# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or 8.x** (`php: ^7.4 || ^8`).
- Core's **Views** module (`views`) — enabled as a dependency (it is on by default
  on a standard site).

There are no third-party Composer or PHP library requirements. Note that this module
provides no data source of its own — you will also need a companion module (your own,
or a contrib integration built on top of this one) to actually fetch remote data.

## Install with Composer

From the project root:

```bash
composer require drupal/views_remote_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_remote_data -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_remote_data -y
```

There is no configuration screen. Enabling the module registers the
`views_remote_data_query` Views query plugin, the property handlers, the cache
plugins and the Views wizard — but nothing appears until a companion module declares
a remote base table and answers the module's events. See the
[How to use it](../index.md#how-to-use-it) section and the
[`agent/` setup docs](../agent/configure/setup.md) for that.

## Trying the bundled examples

The project ships reference implementations under `tests/modules/`:

- **`views_remote_data_test`** — returns rows from a JSON fixture (no network).
- **`views_remote_data_pokeapi`** — calls the live PokéAPI over the network.

Enabling one of these (e.g. `drush en views_remote_data_test -y`) gives you a
working remote-data base table to build a View against, which is the quickest way to
see the module in action before writing your own integration.
