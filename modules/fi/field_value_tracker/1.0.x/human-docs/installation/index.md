# Installation

## Requirements

- **Drupal core 11.0 or higher** (`core_version_requirement: ^11`).
- **PHP 8.3 or higher.**
- **Drush 12 or higher** — the value swap is performed by the `drush fvt:update`
  command, so Drush is effectively required to get any use out of the module.
- Core's **Field**, **Options**, and **System** modules, which Drupal enables
  automatically as dependencies.

There are no third-party Composer or PHP library requirements, and no external
APIs are involved.

## Install with Composer

From the project root:

```bash
composer require drupal/field_value_tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_value_tracker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_value_tracker -y
```

## Grant the permission

The module ships an **Administer field value tracker** permission. Go to
**People → Permissions** (`/admin/people/permissions`) and grant it only to roles
you trust — the tracked values can include credentials-adjacent configuration such
as login URLs and email addresses, so keep this to administrators.

## Verify it worked

Log in as a user with the permission and visit **Configuration → Development →
Field Value Tracker** (`/admin/config/development/field-value-tracker`). You should
see the tracker list with an **Add field value tracker item** button. From the
command line, `drush fvt:update --dry-run` should run and report that there is
nothing to change yet. Next, add your field mappings in
[Configuration](../configuration/index.md).
