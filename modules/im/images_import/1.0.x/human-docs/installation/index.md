# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Standard core image and/or media fields on the entities you want to import into
  (the module works with both).

There are no third‑party Composer or PHP library requirements.

> **Note:** This project is **not covered by Drupal's security advisory policy**.
> Review it accordingly before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/images_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/images_import -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en images_import -y
```

## Grant the import permission

The module provides its own permission for running imports. Go to **People →
Permissions** (`/admin/people/permissions`), grant it to the roles that should be
allowed to import images, and save.

## Verify it worked

Log in as a user with the import permission and open the module's import screen.
If you can reach the CSV upload form, the module is installed and ready. See "How
to use it" in the [overview](../index.md) for preparing the CSV.
