# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; Composer requires
  `drupal/core: ^10 || ^11`).
- No other contrib modules. It builds on core's entity-reference system, which is always
  available.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_quantity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/entity_reference_quantity -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_quantity -y
```

Once enabled, **Entity reference w/quantity** appears as a field type when you add a field to
a content type or other entity. See **How to use it** in the [overview](../index.md) for
configuring the field, its widgets and its formatter.
