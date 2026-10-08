# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`), which is the only dependency and is enabled on
  virtually every site already.

There are no third-party Composer or PHP library requirements. Note that this
version is currently **not compatible with the Diff module** — if you rely on
Diff, watch the project's issue queue before combining the two.

## Install with Composer

From the project root:

```bash
composer require drupal/revisions_bulk_operations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revisions_bulk_operations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revisions_bulk_operations -y
```

## Grant the permission

The bulk-selection interface stays hidden until you grant its permission:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Allow bulk selection of revisions** (machine name
   `bulk select revisions`).
3. Tick it for the roles that should be able to clean up revisions — trusted
   editorial or administrative roles only, since the action permanently deletes
   revisions.
4. Save.

## Verify it worked

Log in as a user in one of the granted roles and open any node's **Revisions**
tab. You should now see checkboxes next to the revisions and a bulk **delete**
action. If the checkboxes are missing, re-check that the role has the
`bulk select revisions` permission and that you are viewing a node (this version
targets node entities).

> **Back up before deleting.** Revision deletion is permanent. Take a database
> backup before your first large cleanup.
