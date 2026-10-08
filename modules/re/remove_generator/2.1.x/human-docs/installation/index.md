# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).

There are no module dependencies and no third‑party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed (there aren't any here, but it's harmless to include).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remove_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_generator -y
```

The moment it's enabled, the Generator meta tag is removed from every page — there
is no configuration step. To restore the tag, uninstall the module:

```bash
drush pmu remove_generator -y
```
