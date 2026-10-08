# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`), used for the report page. It is part of a
  standard Drupal install and is enabled automatically as a dependency.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_delete_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_delete_log -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_delete_log -y
```

The module ships no submodules. Once enabled, it does nothing until you choose
which entity types to log — head to [Configuration](../configuration/index.md).
