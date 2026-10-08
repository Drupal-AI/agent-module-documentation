# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, no third-party Composer libraries, and no special
  PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/uuid_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/uuid_extra -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en uuid_extra -y
```

Enabling the module makes the `uuid` base field appear on the *Manage form display*
and *Manage display* pages of every entity type that has a UUID, and registers the
read-only UUID widget and UUID formatter. There is no configuration step and no
permission to grant — see the [overview](../index.md) for the point-and-click steps
to actually show a UUID.
