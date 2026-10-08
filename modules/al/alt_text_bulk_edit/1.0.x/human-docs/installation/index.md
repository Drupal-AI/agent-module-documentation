# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 | ^12`).
- Core's **Field** (`field`) and **Media** (`media`) modules enabled. Drupal will
  pull these in as dependencies.
- Editors need the core **update any media** permission to use the tool.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alt_text_bulk_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alt_text_bulk_edit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alt_text_bulk_edit -y
```

## Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant
**update any media** to the roles that should be able to bulk-edit alt text. Grant
it only to trusted editors — it allows changing every media item on the site.

Once that's done, open **`/admin/content/media/alt-text`** and start editing —
see [How to use it](../index.md#how-to-use-it).
