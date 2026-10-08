# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third-party Composer or PHP library
  requirements.

If you already run another breadcrumb module (for example one that builds trails
from taxonomy or paths), be aware that Breadcrumb Menu registers its own
breadcrumb builder and the two compete by priority — plan to run one or to sort
out which should win.

## Install with Composer

From the project root:

```bash
composer require drupal/breadcrumb_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/breadcrumb_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en breadcrumb_menu -y
```

Menu-driven breadcrumbs take effect immediately. Grant the **Administer
breadcrumb_menu** permission to the roles that should manage the behaviour, and
adjust it from the settings form at **Configuration → System → Breadcrumb Menu**
(`/admin/config/system/breadcrumb-menu`) — see the
[overview](../index.md#how-to-use-it). If the breadcrumb does not change, check
for a competing breadcrumb module.
