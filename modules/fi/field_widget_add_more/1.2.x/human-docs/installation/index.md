# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- No other module dependencies and no third-party Composer libraries.
- At least one field with a **fixed cardinality greater than 1** for the feature to
  apply to (the "Show add more button" checkbox is only offered on such fields).

## Install with Composer

From the project root:

```bash
composer require drupal/field_widget_add_more -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_widget_add_more -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_widget_add_more -y
```

There is no configuration step or permission to grant. Enabling the module adds a
**Show add more button** checkbox to the widget settings of eligible fields on
**Manage form display** — see the [overview](../index.md) for how to switch it on for
a specific field.
