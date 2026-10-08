# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.
- An administration theme configured at **Appearance** (`/admin/appearance`) — the
  module renders the account pages with whatever admin theme your site uses.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_login_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_login_path -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_login_path -y
```

There are no submodules and nothing to configure. As soon as it's enabled, the
account pages (login, register, password reset, one‑time login, and account
cancellation) render with your administration theme.

On enable, the module also grants core's **View the administration theme**
permission to the anonymous and authenticated roles so those pages display
correctly for logged‑out visitors.

## Verify it worked

Log out and visit `/user/login`. The page should now appear in your admin theme
(for example Claro or Gin) rather than the front‑end theme.

## Uninstalling

```bash
drush pm:uninstall admin_login_path -y
```

This reverts the account pages to the front‑end theme. Note that the **View the
administration theme** permission granted at install is **not** revoked
automatically — remove it by hand on **People → Permissions** if you no longer want
the anonymous/authenticated roles to have it.
