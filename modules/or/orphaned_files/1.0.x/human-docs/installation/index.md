# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — the only dependency, enabled automatically as
  a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/orphaned_files -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orphaned_files -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orphaned_files -y
```

## Grant the permission

Orphaned Files provides its own permission for viewing the report and deleting
files. Because the report can reveal sensitive file paths and deletion is
permanent, grant it only to trusted administrators under **People → Permissions**.

## Verify it worked

Log in as an administrator with the permission and open the **Orphaned Files**
report from the admin area. You should see the list of unreferenced managed files
with the available filters. Remember to verify files are genuinely unused, and
take a backup, before deleting anything.
