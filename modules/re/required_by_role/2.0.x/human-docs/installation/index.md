# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- The **Required API** module (`drupal/required_api`, `^3.0`) — this is a hard
  dependency; Required by role is a plugin that plugs into it.

There are no other third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/required_by_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Required API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/required_by_role -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_by_role -y
```

Drupal enables Required API at the same time if it isn't already on. The
"Required by role" strategy then becomes selectable on any field — see
[Configuration](../configuration/index.md).

## Submodules

None — Required by role ships as a single module.
