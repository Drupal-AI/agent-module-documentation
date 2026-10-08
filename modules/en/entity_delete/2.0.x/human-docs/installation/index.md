# Installation

## Requirements

Entity Delete is lightweight and has no third-party dependencies:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No contrib module dependencies and no Composer libraries to pull in.

It works with core entity types (nodes, users, taxonomy terms, comments, files,
log entries) and any custom content entity type another module provides.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_delete -y
```

There are no submodules.

## Grant the permission

The whole feature is gated by one permission, **Use entity delete module**
(`use entity_delete`), which Drupal flags as security-sensitive ("grant with
care"). Assign it only to trusted administrator roles at
**People → Permissions** (`/admin/people/permissions`). Anyone with it can
irreversibly bulk-delete any content entity type, so treat it like the keys to
the database.

## Verify it worked

Log in as a user with the permission and visit
**Configuration → Entity Delete** (`/admin/config/entity-delete`). You should see
the two-dropdown delete form. See [How to use it](../index.md#how-to-use-it) for
the delete flow.
