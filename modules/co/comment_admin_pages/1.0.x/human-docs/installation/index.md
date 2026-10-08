# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Comment** module (`comment`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_admin_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_admin_pages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_admin_pages -y
```

That's all — there is nothing to configure.

## Verify it worked

As a user who has the **View the administration theme** permission, open a
comment's edit or delete form (for example from **Content → Comments**). The form
should now render in your admin theme rather than the public front‑end theme. Users
without that permission continue to see the forms in the normal theme, and who may
edit or delete comments is unchanged.
