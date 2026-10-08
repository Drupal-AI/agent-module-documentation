# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Schema.org Organization** submodule (`schema_organization`) of the
  **[Schema.org Metatag](https://www.drupal.org/project/schema_metatag)** module —
  this module extends that group, so it must be present and enabled. Schema.org
  Metatag in turn builds on the [Metatag](https://www.drupal.org/project/metatag)
  module.

There are no third-party PHP libraries to install. The
[Config Pages](https://www.drupal.org/project/config_pages) module is optional but
recommended if you want to manage organization data in one place (see the main
guide).

## Install with Composer

From the project root:

```bash
composer require drupal/schema_hospital -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Schema.org Metatag and Metatag if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_hospital -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_hospital -y
drush cr
```

Make sure the `schema_organization` submodule is enabled too — enable it from the
Extend page or with `drush en schema_organization -y` if it is not already on.

## Next step

The module has no settings page of its own — you fill in its 15 new fields inside
the **Schema.org Organization** section of the Metatag UI at **Configuration →
Search and metadata → Metatag**. See the [main guide](../index.md) for the
step-by-step walkthrough.
