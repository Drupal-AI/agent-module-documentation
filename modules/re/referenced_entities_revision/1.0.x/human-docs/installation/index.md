# Installation

## Requirements

Referenced Entities Revision needs:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's node and revision system (part of a standard Drupal install).

There are no other module, Composer, or PHP library dependencies.

> **Note:** this project is **not covered by Drupal's security advisory policy**.
> Weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/referenced_entities_revision -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/referenced_entities_revision -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en referenced_entities_revision -y
```

## Grant the permission

The Revision List tab is gated by core's **View all revisions** permission. Grant
it to the roles that need the tab at **People → Permissions**
(`/admin/people/permissions`), then save.

## Verify it worked

As a user who has the **View all revisions** permission, open a node that
references other nodes. You should see a **Revision List** tab; clicking it shows
the combined revision table for the node and its referenced nodes. See the parent
[guide](../index.md#how-to-use-it) for how to read and use the table.
