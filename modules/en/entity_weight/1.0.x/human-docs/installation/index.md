# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** and **Field UI** modules (included with Drupal and enabled by
  default).
- No third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_weight -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_weight -y
```

## Grant the permission

The module provides its own permission for administering entity weights. At
**People → Permissions** (`/admin/people/permissions`), grant it to the roles
that should manage ordering.

## Verify it worked

Visit **Configuration → Entity Weight** (`/admin/config/entity-weight`). If the
settings page loads with a list of entity types and bundles you can enable, the
module is active. See [Configuration](../configuration/index.md) to enable
weighting on a bundle and start reordering.

> If new menu links or settings do not appear right away, clear caches with
> `drush cr` (or **Configuration → Performance → Clear all caches**).
