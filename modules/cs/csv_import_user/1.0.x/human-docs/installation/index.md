# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** (`user`) and **File** (`file`) modules — both are dependencies
  and are enabled automatically.
- No third‑party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/csv_import_user -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/csv_import_user -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en csv_import_user -y
```

The import form is available only to users with the **Administer users**
(`administer users`) permission — the same privilege required to create users and
assign roles manually.

## Verify it worked

Log in as a user with **Administer users** and go to **Configuration → People →
User import** (`/admin/config/people/user-import`). The import form should be
available. Before importing real data, consider testing with a small sample CSV
and reviewing the results under **People** (`/admin/people`). See the
[main guide](../index.md#how-to-use-it) for the CSV format and the account‑creation
and privacy cautions.
