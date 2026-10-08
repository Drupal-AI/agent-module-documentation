# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Voting API** module (`drupal/votingapi` `^4.0`) — Fivestar is built on top
  of it, and it's a required dependency. Composer installs it for you.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fivestar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies — including Voting API — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fivestar -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fivestar -y
```

This also enables Voting API if it isn't already on. Once enabled, the **Fivestar
rating** field type becomes available when you add a field to any entity bundle —
see [Configuration](../configuration/index.md).

This module ships no submodules.
