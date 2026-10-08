# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`; Composer requires
  `drupal/core: ^10.2 || ^11`).
- No other contrib modules are required to use the core field. Optional integrations only
  come into play if you also run the relevant module — **Feeds** (import rows), **GraphQL
  Compose** (expose the field to GraphQL), or a charting library for the Chart formatter.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/datafield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/datafield -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datafield -y
```

Once enabled, **Data Field** appears as a field type when you add a field to any content
type or other fieldable entity. See **How to use it** in the [overview](../index.md) for
defining its columns, widgets and formatters.
