# Installation

## Requirements

- **Drupal 8.7.7 or newer — 8.8+, 9, 10, or 11**
  (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module — enabled automatically as a dependency.

There are no third‑party Composer packages or external libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_cross_bundles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_cross_bundles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_cross_bundles -y
```

This also enables core JSON:API if it isn't already on. There is no configuration
step.

## Verify it worked

Confirm the module shows as enabled on the **Extend** page, then have your
JSON:API consumer request a cross-bundle collection and check that the response
contains items from more than one bundle of the entity type. Because access
remains per entity, verify the results only include content the requesting user is
allowed to see.
