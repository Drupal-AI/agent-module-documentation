# Installation

## Requirements

Search API Fast needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Search API** (`search_api ^1.0`) — declared as a Composer requirement as well
  as a module dependency.
- **Drush**, and a **Unix/Linux-based system**. The module spawns parallel Drush
  worker processes, so it relies on a command-line environment; it is not usable
  from a browser request.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_fast -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/search_api_fast`)
matches the module's machine name (`search_api_fast`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_fast -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_fast -y
```

## Verify it worked

Confirm the Drush command is registered:

```bash
drush sapi-fast --help
```

You should see the `sapi-fast` command described. From here, review the optional
[Configuration](../configuration/index.md) — especially the worker count — before
running it against a large index, and test on a copy of production first.
