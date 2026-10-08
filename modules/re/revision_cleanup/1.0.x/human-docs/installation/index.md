# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_cleanup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_cleanup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_cleanup -y
```

## Verify it worked

Go to **Configuration → System → Revision Cleanup**
(`/admin/config/system/revision-cleanup`). You should see the settings form for
retention. **Do not run cleanup yet** — read [Configuration](../configuration/index.md)
first, including the irreversibility warning, and take a backup before the first
run on real data.
