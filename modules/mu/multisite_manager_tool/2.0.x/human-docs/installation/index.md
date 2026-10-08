# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed‑module dependencies and no third‑party libraries.
- A genuine **Drupal multisite** setup for the tool to be useful (multiple sites
  under `sites/`). It is built for that environment.
- For the **create‑site / create‑database** feature to work, the database user
  in your site's configuration must have permission to **create databases**.
  Confirm this before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/multisite_manager_tool -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multisite_manager_tool -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multisite_manager_tool -y
```

If you enable it on a multisite that already has several sites configured, the
module runs a **reconciliation** step that detects and registers those existing
sites automatically.

## Grant the permission

This module provides its own permission. Because its actions can affect several
sites at once, grant it **only to fully trusted administrators** at **People →
Permissions** (`/admin/people/permissions`). See
[Configuration](../configuration/index.md) for what that access unlocks.

## Verify it worked

Log in as an administrator with the module's permission and open **Configuration
→ System → Multisite Manager** (`/admin/config/system/multisite-manager`). You
should see your active sites listed — proof that detection and reconciliation
worked.
