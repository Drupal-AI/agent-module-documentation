# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No third-party Composer or PHP library requirements are declared.
- To create a mapping you will need matching fields to compare: one on the entity
  (node or taxonomy term) and one on the user account, both of the same
  **entity-reference** or **boolean** type.

## Install with Composer

From the project root:

```bash
composer require drupal/access_by_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_by_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_by_field -y
```

## Grant the settings permission

Under **People → Permissions**, grant **`access abf mapping settings page`** to
trusted administrators only — it controls who can define the access mappings that
govern content visibility. Do not give it to ordinary roles.

Next, create your first mapping — see [Configuration](../configuration/index.md).
