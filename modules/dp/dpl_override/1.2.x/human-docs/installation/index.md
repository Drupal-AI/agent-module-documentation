# Installation

## Requirements

DPL Override is about as lightweight as a module gets. It needs:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).

There are no module dependencies, no third‑party Composer requirements, and no
PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dpl_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dpl_override -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dpl_override -y
```

## Verify it worked

Go to **Extend** (`/admin/modules`) and confirm **DPL Override** shows as
enabled. That is the whole story — the module adds no routes, no permissions,
and no configuration, so there is nothing else to check. When you are done with
it, uninstall it from the same page; it holds no data and cleans up completely.
