# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** (`system`) and **User** (`user`) modules — always present on a
  Drupal site; they're listed as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/frontend_asset_debugger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/frontend_asset_debugger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en frontend_asset_debugger -y
```

## Grant permissions

The module provides two permissions — grant them at **People → Permissions**
(`/admin/people/permissions`):

- **Access frontend asset debugger** — view the read‑only reports. Suitable for
  developer roles.
- **Administer frontend asset debugger** — change settings and run page scans. This is
  a **restricted** administrator permission; grant it only to trusted roles.

## Verify it worked

Go to **Reports → Frontend assets** (`/admin/reports/frontend-assets`). You should see
the asset overview report listing your site's declared libraries. From there, follow
[Configuration](../configuration/index.md) to tune settings and optionally run a page
scan.
