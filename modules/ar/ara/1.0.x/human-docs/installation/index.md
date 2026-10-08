# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (`system`) — always present in a Drupal install; this
  is the only dependency.

There are no third‑party Composer or PHP library requirements. This is a
development/debugging tool intended for **local or dev environments**, not
production.

## Install with Composer

From the project root:

```bash
composer require drupal/ara -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. On a project where you keep dev tools separate, you may
prefer `composer require --dev drupal/ara`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ara -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ara -y
```

Then grant the **Use ara profiler** permission (**People → Permissions**,
`/admin/people/permissions`) to your developer/administrator role so the profiler
output is visible. See [How to use it](../index.md#how-to-use-it).

This module has no submodules.
