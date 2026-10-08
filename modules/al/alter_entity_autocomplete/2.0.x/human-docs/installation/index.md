# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- No module dependencies, and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alter_entity_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alter_entity_autocomplete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alter_entity_autocomplete -y
```

Once enabled, choose which entity types allow direct input on the module's settings
form — see [How to use it](../index.md#how-to-use-it).
