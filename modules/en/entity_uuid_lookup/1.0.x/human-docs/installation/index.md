# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies and no third‑party Composer or PHP libraries.

The admin toolbar button and menu link appear only for users who hold both the
**Lookup entities by UUID** and **View the administration theme** permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_uuid_lookup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_uuid_lookup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_uuid_lookup -y
```

## Grant the permissions

At **People → Permissions** (`/admin/people/permissions`), give the roles that
need the tool:

- **Lookup entities by UUID** — access to the lookup form itself.
- **View the administration theme** (core) — so the toolbar button and admin
  menu link render.

Keep these limited to trusted administrators.

## Verify it worked

Log in as a user with both permissions. You should see a **UUID lookup** button
in the admin toolbar. Click it, paste a known entity's UUID, and confirm you are
redirected to that entity.
