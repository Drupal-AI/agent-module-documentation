# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Schema.org Metatag](https://www.drupal.org/project/schema_metatag)**
  module (`schema_metatag`) — this module extends it, so it must be present and
  enabled. Schema.org Metatag in turn builds on the
  [Metatag](https://www.drupal.org/project/metatag) module.

There are no third-party PHP libraries to install. It is also useful (but not
required) to add the `schema_vacation_rental` module alongside this one.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_accommodation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Schema.org Metatag and Metatag if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_accommodation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_accommodation -y
```

## Next step

The module has no settings page of its own — you configure the Accommodation
fields inside the Metatag UI at **Configuration → Search and metadata → Metatag**.
See the [main guide](../index.md) for the step-by-step "how to use it" walkthrough.
