# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** module (`node`) enabled — this is the only dependency, and it is
  part of a standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_deletion_guard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_deletion_guard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_deletion_guard -y
```

## Grant the permission

The lock/unlock screen is gated by the module's **Manage locked pages**
permission. At **People → Permissions** (`/admin/people/permissions`), grant it to
the roles that should be allowed to lock and unlock pages, then save. Grant it
deliberately — a user who can reach the lock screen can also unlock a page and then
delete it.

## Verify it worked

Go to **Content → Lock pages** (`/admin/content/lock-pages`). You should see the
search‑and‑select screen for locking nodes. Lock a test node, then confirm a 🔒
appears next to its title on the content overview and that attempting to delete it
is blocked. Untick it to restore normal deletion.
