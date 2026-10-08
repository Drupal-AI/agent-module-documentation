# Installation

## Requirements

Entity Reference Unpublished is lightweight and self-contained:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No third-party Composer packages, no PHP library requirements, and no other
  contrib modules are required. It builds on Drupal core's entity-reference system.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_unpublished -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_unpublished -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_unpublished -y
```

Enabling the module makes the three new **Reference method** options available. It
does not change any existing fields on its own — you switch a field to an unpublished
handler yourself, as described on the [main page](../index.md#how-to-use-it).
