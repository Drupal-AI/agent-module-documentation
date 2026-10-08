# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other Drupal module dependencies and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cm_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cm_tools -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cm_tools -y
```

If another custom module lists `cm_tools` as a dependency, enabling that module will
enable this one automatically.

## Verify it worked

There is no UI to check. Confirm the module shows as enabled at **Extend**
(`/admin/modules`) or via `drush pml | grep cm_tools`. The helpers are then
available to any code that depends on it.
