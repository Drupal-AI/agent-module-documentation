# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`) — the computed field reflects Group's
  relationships.
- Optionally the **Search API** module, if you want to index and filter entities
  by their groups (this is the module's primary use case).

## Install with Composer

From the project root:

```bash
composer require drupal/group_computed_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_computed_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_computed_field -y
```

Drupal enables the Group dependency automatically if it isn't already on.

## Verify it worked

On an entity type that can be related to groups, open **Manage display** (or the
Views UI, or your Search API index's field list) and confirm the computed group
field is available. For an entity that belongs to a group, the field should report
that group.
