# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- No other contrib modules, PHP libraries or third-party Composer packages are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/session_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/session_entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en session_entity -y
```

## After enabling

There is no settings form. Grant the module's permission to the roles that should
edit their session entity (**People → Permissions**), add any fields you want to the
session entity type through the field UI, and use the `session_entity.current`
service from your own code to read and write the current user's entity. See the
"How to use it" section of the [main guide](../index.md).
