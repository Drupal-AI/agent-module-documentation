# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Field Group** module (`field_group`), version `~3.0 || ~4.0` — this
  module builds on Field Group's grouping system.

There are no third‑party PHP library requirements.

> **Note on stability:** the module's `composer.json` declares
> `"minimum-stability": "dev"`, which is worth knowing if you're pinning exact
> versions during dependency resolution.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_metadata -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Field Group dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_group_metadata -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_metadata -y
```

This also enables Field Group if it isn't already on.

## Verify it worked

Go to a content type's **Manage form display**, add a **Details** field group
with the machine name `group_metadata`, drag a field into it, and save. Open the
content edit form — the group should now appear in the right‑hand sidebar next
to the authoring information and revision log, rather than in the main column.
