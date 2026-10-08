# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Administer Users by Role** module (`administerusersbyrole`) — this add-on
  extends it and does nothing on its own. Composer pulls it in as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/administerusersbyrole_custom_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including pulling in Administer Users by Role — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/administerusersbyrole_custom_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en administerusersbyrole_custom_actions -y
```

Drupal enables Administer Users by Role at the same time if it is not already on.

## Configure access (required for it to do anything)

This module ships a **`block users`** permission but no settings form of its own.
Two steps make it work, and both are access-sensitive:

1. In **Administer Users by Role**'s configuration, mark the roles that sub-admins
   are allowed to act on as **safe**. This list defines exactly which users a
   sub-admin can block or unblock.
2. On **People → Permissions** (`/admin/people/permissions`), grant **block
   users** to your sub-admin role only. Anyone with the core *Administer users*
   permission bypasses these role checks, so grant that separately and
   deliberately.

Always verify the result by testing as the sub-admin account rather than as
user 1. See the [overview](../index.md) for the full workflow and cautions.
