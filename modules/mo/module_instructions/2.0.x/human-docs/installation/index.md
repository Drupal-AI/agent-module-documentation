# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9.0 || ^10 || ^11`).
- No PHP version constraint beyond what your Drupal core requires.
- **No third‑party module or library dependencies.**

## Install with Composer

From the project root:

```bash
composer require drupal/module_instructions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_instructions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_instructions -y
```

## Verify it worked

Go to **Extend** (`/admin/modules`). Enabled modules should now show
README/CHANGELOG/LICENSE links in their *Operations* column — click one to read the
file rendered in the admin UI. If you do not see the links, confirm your role has the
**Access module instruction files** permission and check which links are enabled on
the settings page at **`/admin/config/system/module-instructions`**.
