# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 7.4 or higher**.
- The **Entity Usage** module (`entity_usage`, the 8.x-2.x branch) enabled and
  configured — this is a hard dependency and the source of the reference data
  this tool rewrites. Only references Entity Usage tracks can be updated.

There are no third‑party Composer library requirements beyond Entity Usage.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_updater -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Usage and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_usage_updater -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_updater -y
```

## Set up the prerequisite

Before the tool can do anything useful:

1. Make sure **Entity Usage** is installed and configured, and that it is
   tracking the reference types you want to change (entity reference fields, text
   links, Link fields, Linkit links).
2. Grant the **`update referenced entities`** permission to the trusted roles
   that will run bulk updates. This is a sensitive, restricted permission because
   it rewrites arbitrary content — keep it admin-only.

## Verify it worked

Log in as a user with the `update referenced entities` permission and visit
**Content → Update entity references** (`/admin/content/update-references`). If
the form loads, the module is active. See
[Configuration](../configuration/index.md) for how to run an update safely.
