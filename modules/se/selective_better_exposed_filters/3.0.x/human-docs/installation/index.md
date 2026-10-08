# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contrib **Better Exposed Filters** module (`drupal/better_exposed_filters`,
  version `^4.0 || ^5.0 || ^6.0 || ^7.0`), which in turn requires core **Views**.
  Composer pulls in a compatible BEF release for you.

## Install with Composer

From the project root:

```bash
composer require drupal/selective_better_exposed_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Better Exposed Filters if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/selective_better_exposed_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en selective_better_exposed_filters -y
```

Enabling it turns on Better Exposed Filters too (as a dependency). The new options
then appear in the exposed-filter settings of any view that uses a BEF widget —
there is nothing else to configure globally, and there are no submodules.
