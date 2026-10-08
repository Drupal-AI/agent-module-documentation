# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Layout Builder** (`layout_builder`) modules.
  Layout Builder in turn relies on core's Layout Discovery and (for inline blocks)
  the Block Content / Custom Block module. Drupal enables the direct dependencies
  automatically when you turn on Duplicate Node.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/duplicate_node -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/duplicate_node -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en duplicate_node -y
```

## Grant the duplicate permission

Duplicating creates new content, so decide carefully who may do it. Go to
**People → Permissions** (`/admin/people/permissions`), find the Duplicate Node
permission, and grant it only to the roles that should be able to clone nodes. Save
permissions.

## Verify it worked

Log in as a user with the permission, open any node, and confirm a **Duplicate** tab
now appears alongside View/Edit. Clicking it should open a new node pre‑filled from
the original. If the original uses Layout Builder and duplication is enabled in the
settings, the new node should carry over its layout and inline blocks too.
