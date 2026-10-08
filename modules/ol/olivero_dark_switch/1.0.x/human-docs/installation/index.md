# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Olivero** theme in use — the module alters Olivero's CSS variables,
  so it's designed specifically for Olivero.

There are no third‑party Composer libraries, external JavaScript libraries, or other
module dependencies to install.

> **Pre‑release:** the current release is **1.0.0‑alpha1**. Treat it as pre‑release.

## Install with Composer

From the project root:

```bash
composer require drupal/olivero_dark_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/olivero_dark_switch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en olivero_dark_switch -y
```

## Verify it worked

Place the **Olivero Dark Switch** block in a region at **Structure → Block layout**
(see the [guide overview](../index.md)), then visit an Olivero‑themed page and
confirm the toggle appears and switches the site between light and dark, remembering
your choice on reload.
