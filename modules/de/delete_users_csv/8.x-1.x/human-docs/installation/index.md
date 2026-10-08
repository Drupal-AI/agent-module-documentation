# Installation

> **Before you install:** this module **bulk‑deletes user accounts** listed in a
> CSV, the deletion is **irreversible**, it **cascades to each user's content**
> per your account‑cancellation settings, and the CSV contains **personal data**.
> Take a database backup and review the warnings in the [overview](../index.md)
> before using it.

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **User** module (always present).

There are no other module dependencies, and no PHP library or third‑party
Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/delete_users_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/delete_users_csv -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en delete_users_csv -y
```

## Verify it worked

Log in as a user with the **administer users** permission and go to
`/admin/delete-users-csv`. If the upload form loads, the module is active. Do
**not** upload a CSV or run a deletion until you have taken a backup, verified the
CSV, and confirmed your account‑cancellation setting — see the
[overview](../index.md) for the full workflow and warnings.
