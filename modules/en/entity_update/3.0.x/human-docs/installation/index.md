# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **Drush 10 or 11** if you want to use the command-line workflow (recommended).
- No other contrib modules, Composer libraries or PHP extensions are required.

Access to the module is controlled by core's **Administer software updates**
permission, which is a restricted-access permission — only user 1 or a trusted
administrator role should have it.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_update -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_update -y
```

Enabling the module registers the `upe` and `upec` Drush commands and adds the
web UI under **Configuration → Development → Entity update**. It defines no
permission of its own — everything is gated by core's **Administer software
updates**, which administrators typically already have.

## A word of caution

Entity Update is a developer tool that changes your database schema and, on the
safe path, deletes and recreates entity records. **Back up your database before
using it**, and prefer the Drush workflow over the browser on production sites.

## Verify it worked

Confirm the Drush commands are available:

```bash
drush upe --show
```

This prints any pending entity schema changes (or reports that there are none)
without modifying anything. You can also visit **Configuration → Development →
Entity update → Status** (`/admin/config/development/entity-update/status`) to see
the same information in the browser. See the
[overview](../index.md#how-to-use-it) for how to run updates.
