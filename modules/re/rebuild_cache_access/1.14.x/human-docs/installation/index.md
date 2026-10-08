# Installation

## Requirements

Rebuild Cache Access is deliberately lightweight. It needs:

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement:
  ^10.1 || ^11`).
- Core's **Toolbar** module (`toolbar`) enabled — Drupal turns it on automatically
  as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rebuild_cache_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rebuild_cache_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rebuild_cache_access -y
```

## Grant the permission

The button is hidden until a role holds the **Rebuild Cache** permission. Go to
**People → Permissions** (`/admin/people/permissions`), tick the **Rebuild Cache**
box for the roles that should have it, and save. Those users will see the
**Rebuild Cache** tab in the admin toolbar on their next page load.

There are no submodules.
