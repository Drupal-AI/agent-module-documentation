# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9.0 || ^10 || ^11`).
- The **`doctrine/dbal`** PHP library (`^2.5 || ^3.0`), which provides the
  Doctrine DBAL connection. Composer installs it for you.

Optionally, the **`doctrine/persistence`** library — install it if you need the
module's Doctrine `ConnectionRegistry` service (some Doctrine ORM/DBAL tooling
expects one).

There is no separate database configuration to set up: the module derives its
connection from Drupal's existing `$databases` settings.

## Install with Composer

From the project root:

```bash
composer require drupal/dbal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`doctrine/dbal` library at a compatible version. If you need the connection
registry, add the persistence library too:

```bash
composer require drupal/dbal doctrine/persistence -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dbal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dbal -y
```

The module ships no submodules, and there is nothing to configure — its services
are available to other code as soon as it is enabled.

## Verify it worked

The module is a developer tool with no UI, so the best check is from code (or
`drush php`): fetch the `dbal_connection` service and confirm it is a
`Doctrine\DBAL\Connection`. See the [`agent/`](../agent/start.md) docs for exact
service names and usage examples.
