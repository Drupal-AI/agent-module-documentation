# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Action** module (`action`).
- The contrib **Entity API** module (`entity`,
  `drupal/entity`) — Composer pulls this in for you.
- A **single-value entity reference field** on the destination bundle that points
  back at the source (this is what links a destination to its source; multi-value
  reference fields are not yet supported).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_value_inheritance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Entity API
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_value_inheritance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_value_inheritance -y
```

Drupal enables the Action and Entity API dependencies automatically.

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant **Administer
inheritance** to trusted administrators. This one permission gates the mapping
list, the add/edit/delete forms, and the global settings form.

## Verify it worked

Visit **Structure → Inheritance** (`/admin/structure/inheritance`). If the
Inheritance listing loads with an **Add Inheritance** button, the module is
active. Head to [Configuration](../configuration/index.md) to create your first
mapping.
