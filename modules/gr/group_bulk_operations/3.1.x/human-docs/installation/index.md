# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Group** module (`group`) — this module adds bulk actions for it.
- Core's **Views** module (enabled by default) to build the group listing view
  that hosts the bulk‑operations field.

## Install with Composer

From the project root:

```bash
composer require drupal/group_bulk_operations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_bulk_operations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_bulk_operations -y
```

Drupal enables the Group dependency automatically if it isn't already on.

## Grant permissions

The bulk action forms are gated by the **Administer group** permission
(`administer group`). Confirm the roles that should perform bulk membership and
role changes hold it at **People → Permissions** (`/admin/people/permissions`).
This is the correct gate — there is no case for a lesser one, because these
actions change memberships and roles across many groups at once.

## Verify it worked

Edit a group listing view, add a bulk‑operations field, and confirm the
**"Assign group role and Remove Group User"** action appears in the list of
available actions. Then open the group list and check that ticking groups and
applying the action works as expected on a test selection.
