# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond core. The optional **Views Data Export** module is only needed
if you want to export usage data as CSV, JSON, or XML from a View.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_explorer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_usage_explorer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_explorer -y
```

## Assign the permission

The module adds a permission, **Access Entity Usage overview page**. Grant it to
the roles that should read usage data:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Tick **Access Entity Usage overview page** for the appropriate roles.
3. Save permissions.

## Verify it worked

Open a content entity you know is referenced elsewhere, click the **"Usage"**
operations link (or visit `/admin/usage/{entity_type}/{entity_id}` directly), and
confirm the overview lists where it's used. For detailed installation and
configuration guidance, see the project's README.
