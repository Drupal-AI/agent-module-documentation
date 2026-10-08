# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).

There are no other Drupal module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/htmx_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/htmx_config -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htmx_config -y
```

Often you won't enable this module directly — a module that needs it (for example
HTMX Extras) will pull it in as a dependency.

## Verify it worked

Confirm the module appears as enabled on **Extend** (`/admin/modules`) or via
`drush pm:list --status=enabled`. There is no settings page to visit; once enabled,
its API is available to any module that depends on it.
