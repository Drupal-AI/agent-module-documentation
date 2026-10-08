# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`), **Field** (`field`), and **System** (`system`) modules
  — all part of standard Drupal and enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements. This is a release
candidate (`1.0.0-rc1`).

## Install with Composer

From the project root:

```bash
composer require drupal/clean_filename -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clean_filename -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clean_filename -y
```

## Grant the permission

Clean Filename adds an `administer clean filename` permission. Assign it to the
roles that should manage the feature under **People → Permissions**.

## Verify it worked

Enable Clean Filename on a file or image field (see "How to use it" in the
[overview](../index.md)), then upload a file whose name matches one already present
in that field. The **new** upload should keep the clean, unsuffixed name, and the
**existing** file should be moved to the next available suffix (for example
`document_1.pdf`).
