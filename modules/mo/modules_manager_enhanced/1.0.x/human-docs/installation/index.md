# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4** or higher.
- Core's **System** module (always present) — the only dependency.
- A modern browser with **JavaScript enabled** for the filtering controls.
- Users need the **Administer modules** permission to see the enhanced interface.
- No third‑party contributed modules, external libraries, or APIs are required.

## Install with Composer

From the project root:

```bash
composer require drupal/modules_manager_enhanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modules_manager_enhanced -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **Note:** at the time of writing this project's release is an alpha
> (`1.0.0-alpha1`); test it on a non‑production environment first.

## Enable the module

```bash
drush en modules_manager_enhanced -y
```

## Verify it worked

Go to **Extend** (`/admin/modules`) as a user with the **Administer modules**
permission. You should see a new **Filter by Package** section at the top of the page,
showing only Core and Administration packages by default. No configuration is required
— see "How to use it" in the [overview](../index.md).
