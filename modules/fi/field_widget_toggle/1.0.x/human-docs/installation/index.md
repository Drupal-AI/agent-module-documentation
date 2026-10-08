# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library dependencies.

The toggle currently applies only to **multi-value fields using the Entity
Reference Autocomplete widget** (`entity_reference_autocomplete`).

## Install with Composer

From the project root:

```bash
composer require drupal/field_widget_toggle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_widget_toggle -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_widget_toggle -y
```

## Verify it worked

Open the add/edit form for an entity that has a multi-value entity reference field
using the Entity Reference Autocomplete widget. A toggle indicator should appear
above the field's header; clicking it collapses and expands the field's values.
