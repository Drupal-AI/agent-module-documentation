# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Organic Groups** (`og`) — the group framework whose memberships and roles this
  module grants.
- **Commerce License** (`commerce_license`) — the licensing framework whose
  lifecycle (grant, expire, revoke) drives the role assignment. This requires a
  working Drupal Commerce installation.
- **Dynamic Entity Reference** (`dynamic_entity_reference`) — lets a license target
  different group entity types.

You will also need at least one **OG group entity** and the **OG roles** you intend
to grant already defined on your site.

Drupal will pull the module dependencies in when you install with Composer. This
release is `3.1.0`; the project is marked *not covered* by Drupal's security
advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_license_og_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (OG, Commerce License, Dynamic Entity Reference) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_license_og_role -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_license_og_role -y
```

This also enables OG, Commerce License, and Dynamic Entity Reference if they are
not already on.

## Verify it worked

On a license‑enabled Commerce product variation, edit its license field: the **OG
Role** (`commerce_license_og_role`) license type should now be selectable. You
should also see the new permissions under **People → Permissions** (see
[Configuration](../configuration/index.md) for how to assign them).
