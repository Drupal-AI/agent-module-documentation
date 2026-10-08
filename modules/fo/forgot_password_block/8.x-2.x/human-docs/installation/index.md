# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`) and **Block** module (`block`) — both are
  standard, and Drupal enables them as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/forgot_password_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forgot_password_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forgot_password_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in a region — the **Forgot Password** block should be available. Place it,
then load a page in that region (as an anonymous visitor) and confirm the
email‑address reset form appears. See the [main guide](../index.md) for placement
tips.
