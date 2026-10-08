# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — a hard dependency, and the reason the
  fields appear on the block configuration form. Drupal enables it automatically
  as a dependency.
- No contrib dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/block_id -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_id -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_id -y
```

## Grant the permission

The extra fields only show up for users with the **"administer block id"**
permission. Assign it at **People → Permissions**
(`/admin/people/permissions`) to the roles that manage block markup — typically
site builders/administrators. This is a trusted permission, since it lets a user
set raw HTML `id` and class values on blocks.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click
**Configure** on any block. With the permission granted, the form should now
include a **Block ID** field and three CSS-class fields. See
[Configuration](../configuration/index.md) for what each one does.
