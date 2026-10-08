# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Masked Input** jQuery plugin by Josh Bush, which does the actual
  in‑browser masking. Check the module's `README` for whether it ships the library
  or expects you to place it under `/libraries`.

There are no additional Composer or PHP requirements from the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/masked_input -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masked_input -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masked_input -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → User interface → Masked
Input** (`/admin/config/user-interface/masked_input`). If the settings page loads,
the module is installed and ready — define a mask there and try it on a form field.
See [Configuration](../configuration/index.md).
