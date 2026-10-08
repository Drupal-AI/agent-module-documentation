# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer packages or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/roles_permission_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/roles_permission_builder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en roles_permission_builder -y
```

## Verify it worked

Once enabled, the module is ready to build roles from your YAML files. Add or
point it at your role/permission YAML (see "How it works" on the
[overview page](../index.md)), then confirm on **People → Permissions** that the
roles and permissions you declared were applied as expected. Because these files
determine who can do what, treat that first review as a security check, not just a
smoke test.
