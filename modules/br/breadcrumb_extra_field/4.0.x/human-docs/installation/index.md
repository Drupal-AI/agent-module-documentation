# Installation

## Requirements

Breadcrumb Extra Field relies only on core:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer**.
- Core's **System** (`system`) and **Field** (`field`) modules — both enabled by
  default.

There are no third‑party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/breadcrumb_extra_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/breadcrumb_extra_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en breadcrumb_extra_field -y
```

## Grant the permission

The module defines an **Administer breadcrumb extra field** permission at **People →
Permissions** (`/admin/people/permissions`), which controls who can open the settings
form and choose which entity types and bundles offer the breadcrumb field. Grant it to
site builders/administrators as appropriate.

Once enabled, follow the two‑step setup in
[How to use it](../index.md#how-to-use-it) to enable the field and position it.
