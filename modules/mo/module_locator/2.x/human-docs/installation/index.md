# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No PHP version constraint beyond what your Drupal core requires.
- **No third‑party module or library dependencies.**

## Install with Composer

From the project root:

```bash
composer require drupal/module_locator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_locator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_locator -y
```

## Verify it worked

Go to **Extend** (`/admin/modules`). Each listed module should now display its
filesystem path. There is no configuration to do.
