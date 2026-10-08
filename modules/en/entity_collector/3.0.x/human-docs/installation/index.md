# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **System** module (always present).
- The module uses the **Extra Field** module to expose the per-type add/remove fields;
  install it if it is not already available on your site.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_collector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_collector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_collector -y
```

## Grant the permissions

Under **People → Permissions** (`/admin/people/permissions`), grant the collection
permissions to the appropriate roles:

- **view / add / edit / delete published entity collection entities** (and the
  matching **unpublished** grants) for the users who will build and manage
  collections;
- **revision** grants (view/revert/delete) where you use revisions;
- **administer entity collection entities** — the admin overview permission; this is
  marked *restricted*, so grant it to trusted administrators only.

## Verify it worked

Log in as a user with the admin permission and go to **Structure → Collection
types** (`/admin/structure/collection-types`). You should be able to create a
collection type there. Next, see [Configuration](../configuration/index.md) to set
up a collection type and place the Collection Bar block.
