# Installation

## Requirements

- **Drupal 10.2+, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- The **Components** module (`components`).
- The **Component Schema** module (`component_schema`).

Composer pulls both dependency modules in for you.

> **Note on release status:** the current release is an alpha (1.0.0-alpha7 /
> 1.0.x-dev). Treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/bulma_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulma_components -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulma_components -y
```

Drupal enables the Components and Component Schema dependencies at the same time.
The Bulma components are then available for your theme to use. There is no
configuration step.
