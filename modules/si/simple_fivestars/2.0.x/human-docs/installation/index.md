# Installation

## Requirements

Simple Fivestars is deliberately lightweight:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No dependent modules, no PHP libraries, and no third‑party Composer packages.

The widget and formatter attach to core's own **integer**, **decimal**, and
**float** field types, so you need a numeric field to place them on — but that is
core functionality, not an extra dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_fivestars -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_fivestars -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_fivestars -y
```

## Verify it worked

Once enabled, edit the form display of any bundle that has an integer, decimal, or
float field: the **Fivestars** widget appears in the widget dropdown, and
**Fivestars** appears as a formatter choice on that field's display. Set both, then
edit a piece of content — you should see a row of clickable stars for the field.
There is no configuration form to visit.
