# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Field Group** module (`field_group`) — this module adds a new format to
  Field Group's grouping system.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_nav -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Field Group dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_group_nav -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_nav -y
```

This also enables Field Group if it isn't already on.

## Verify it worked

On any entity's **Manage display**, add a field group and open its format
dropdown — you should see the **Nav item** (and `<nav>`) format listed. Assign
it, move a field into the group, save, and view the entity: the grouped content
should be wrapped in a semantic `<nav>` element.
