# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Schema.org Metatag](https://www.drupal.org/project/schema_metatag)**
  module, **version 2.5.x or higher** (`schema_metatag`) — this module extends it,
  so it must be present and enabled. Schema.org Metatag in turn builds on the
  [Metatag](https://www.drupal.org/project/metatag) module.

There are no third-party PHP libraries to install. The module's declared PHP
requirement (`7.2.0`) is stale metadata and does not restrict a modern site.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_education -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Schema.org Metatag and Metatag if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_education -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_education -y
```

## Next step

The module has no settings page of its own — you configure the
EducationalOccupationalProgram fields inside the Metatag UI at **Configuration →
Search and metadata → Metatag**. See the [main guide](../index.md) for the
step-by-step walkthrough, and take care to map each property to the field that
genuinely holds it.
