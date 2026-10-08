# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Convivial Core** module (`convivial_core:convivial_core`), which is
  installed and enabled as a dependency.

There are no third‑party Composer or PHP library requirements. This module is
intended for use as part of a Convivial‑based site.

## Install with Composer

From the project root:

```bash
composer require drupal/convivial_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Convivial Core and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/convivial_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en convivial_content -y
```

Convivial Core is enabled automatically as a dependency.

## Verify it worked

Go to **Configuration → Convivial CXP → Content Import**. You should see the
content‑import screen, with **Convivial Content** available as a source. Next,
follow [Configuration](../configuration/index.md) to set the source URL and run the
import.
