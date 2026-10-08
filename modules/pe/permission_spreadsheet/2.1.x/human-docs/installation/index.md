# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`) and **User** (`user`) modules — dependencies that
  Drupal handles for you.
- The **PhpSpreadsheet** library (`phpoffice/phpspreadsheet`, `^1 || ^2 || ^3`),
  which is pulled in automatically when you install with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/permission_spreadsheet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
PhpSpreadsheet library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/permission_spreadsheet -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permission_spreadsheet -y
```

## Grant access

The module defines three permissions (assign them at **People → Permissions**,
`/admin/people/permissions`):

| Permission | What it allows |
|---|---|
| **Administer permission spreadsheet** | Change the settings form (marks, filename/title, auto‑preview). |
| **Export permission spreadsheet** | Download the role/permission matrix as a spreadsheet. |
| **Import permission spreadsheet** | Upload a spreadsheet and bulk‑apply grants/revokes to all non‑admin roles. |

**Grant Import (and Administer) only to fully trusted administrators** — see the
security caution on the [overview page](../index.md). None of these permissions
carry Drupal's automatic "restrict access" warning, but Import is effectively as
powerful as *Administer permissions*.

## Verify it worked

Log in as a user with the export permission, go to **People → Permissions →
Spreadsheet export**, and download a sheet — you should get a spreadsheet listing
every permission and a column for each non‑admin role.
