# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`) — always present on a Drupal site; it is the only
  module dependency.
- **PHP 7.4 or PHP 8** (the module is tested on both).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_type_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_type_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_type_permissions -y
```

## Verify it worked

After enabling, open the module's settings form to choose which entity types
generate permissions (see [Configuration](../configuration/index.md)), then visit
**People → Permissions** (`/admin/people/permissions`) and confirm the new
per‑bundle permissions appear, grouped by base entity type (Content, Comment,
Media) and then by bundle.
