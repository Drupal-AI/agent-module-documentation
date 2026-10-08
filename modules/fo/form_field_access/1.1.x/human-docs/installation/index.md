# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies. Optionally, you can install
[Field Permissions](https://www.drupal.org/project/field_permissions) alongside it
if you also need to control who can *view* field values — Form Field Access and
Field Permissions are designed to work together.

> **Note:** This module is not covered by Drupal's security advisory policy
> (`security_advisory_coverage: not-covered`). Take that into account before using
> it on a security‑sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/form_field_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_field_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_field_access -y
```

## Verify it worked

Visit **`/admin/people/form-field-access`**. You should see the configuration page
where you can select an entity type and bundle. If it loads, the module is ready —
see [Configuration](../configuration/index.md).
