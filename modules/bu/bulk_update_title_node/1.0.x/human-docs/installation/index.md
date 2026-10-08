# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's Node module (part of a standard Drupal install).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_update_title_node -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulk_update_title_node -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_update_title_node -y
```

## Grant the permission

Give the roles that should use the tool the **`access bulk update titles nodes`**
permission at **People → Permissions** (`/admin/people/permissions`). Once
granted, those users will find the form at **Content → Bulk update**
(`/admin/content/bulk-update`).
