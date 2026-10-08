# Installation

## Requirements

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- Core's **User** module (`user`) — enabled on every standard Drupal site.
- Optional: **Views Bulk Operations (VBO)** if you want to run the mass reset from
  a custom View rather than the standard People page. This is recommended for very
  large user tables so the work can be batched.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mass_password_change -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mass_password_change -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mass_password_change -y
```

## Verify it worked

Go to **People** (`admin/people`) as a user with the **`administer users`**
permission. The actions drop‑down should now include **Reset password** and
**Change password**. Do not run them in anger until you have read the planning
notes in the [overview](../index.md) — a mass reset locks out every selected user
and cannot be undone.
