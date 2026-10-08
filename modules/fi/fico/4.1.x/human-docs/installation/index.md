# Installation

## Requirements

Field formatter conditions needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Display Suite** (`drupal/ds`) — a required dependency. It's needed both because the module
  integrates its conditions with Display Suite fields and because `ds` is declared as a
  dependency, so Drupal enables it alongside this module.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fico -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Display Suite and update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fico -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fico -y
```

Drupal enables Display Suite as a dependency at the same time. Once enabled, a **Conditions**
section appears in the formatter settings of fields on any *Manage display* tab — there is no
separate configuration step. See the [overview](../index.md#how-to-use-it) for how to add your
first condition.

There are no submodules.
