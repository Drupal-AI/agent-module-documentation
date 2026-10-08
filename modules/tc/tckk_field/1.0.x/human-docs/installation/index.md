# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** (`node`) module — it ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tckk_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tckk_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tckk_field -y
```

## Grant the permission

The module provides its own permission. Visit **People → Permissions** and grant
it to the roles that should have access.

## Verify it worked

Edit a content type's **Manage fields**, add a field, and confirm the **T.C.
Kimlik No** field type appears in the list. Add it, then try saving an entity with
an invalid number — the field should reject it.
