# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Analyze** module (`analyze`) — the framework this plugs into. Composer pulls it
  in; enable it alongside this module.

## Install with Composer

From the project root:

```bash
composer require drupal/analyze_broken_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/analyze_broken_links -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analyze_broken_links -y
```

This also enables the Analyze module if it is not already on. The module provides its
own permissions; grant **Administer analyze settings** to the roles that should be able
to run the broken-link check.
