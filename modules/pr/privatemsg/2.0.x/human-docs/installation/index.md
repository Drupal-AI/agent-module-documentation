# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core modules **Block**, **Datetime**, **Taxonomy**, **User**, **Views**, and
  **Image** — all part of Drupal core and enabled as needed.
- The contributed **[Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations)**
  module (`views_bulk_operations`), which supplies the inbox's bulk actions
  (mark read / delete). Composer fetches it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/privatemsg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Views Bulk
Operations and any shared dependencies at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/privatemsg -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en privatemsg -y
```

Drupal enables the required core modules and Views Bulk Operations at the same
time if they aren't already on.

## Submodules — only if you're migrating

Private Messages ships three optional submodules that exist solely to import
message data from an older site. Enable one only if it matches where your data is
coming from:

| Submodule | Machine name | Purpose |
|-----------|--------------|---------|
| Privatemsg migration (D6) | `privatemsg_migration_d6` | Migrate private messages from a Drupal 6 site |
| Privatemsg migration (D6, variant 2) | `privatemsg_migration_d6_2` | An alternative Drupal 6 migration path |
| Privatemsg migration (D7) | `privatemsg_migration_d7` | Migrate private messages from a Drupal 7 site |

For example:

```bash
drush en privatemsg_migration_d7 -y
```

If you're building a fresh site with no legacy messages, skip these entirely.

## Verify it worked

After enabling and granting the messaging permissions (see
[Configuration](../configuration/index.md)), log in as a member, compose a
message to another user, and confirm it lands in that user's inbox. Place the
new-messages counter block in a region to confirm the block works too.
