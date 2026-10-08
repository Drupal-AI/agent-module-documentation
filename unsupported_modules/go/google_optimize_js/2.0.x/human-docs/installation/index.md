# Installation

> **Before you install:** Google Optimize was sunset on 30 September 2023 and this
> module is unsupported. These steps are provided for reference and for maintaining
> existing sites only — for a live site the recommended action is to *uninstall* it.

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core **Path alias** module (`path_alias`), enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/google_optimize_js -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_optimize_js -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_optimize_js -y
```

## Verify it worked

Go to **Configuration → System → Google Optimize**
(`/admin/config/system/google_optimize`) — the settings form should load. Continue to
[Configuration](../configuration/index.md).
