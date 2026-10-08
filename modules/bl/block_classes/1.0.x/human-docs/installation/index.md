# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — Drupal enables it automatically as
  a dependency when you turn on Block Classes.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_classes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_classes -y
```

## Grant the permission

The three CSS-class fields only appear on the block form for users who have the
**Administer block css classes** permission. Grant it to the roles that should be
allowed to set block classes (for example your themers or site builders), at
**People → Permissions**, or from the CLI:

```bash
drush role:perm:add site_builder 'administer block css classes'
```

Note that this permission does **not** by itself grant access to the block layout
pages — a user still needs core's **Administer blocks** permission to reach a
block's configure form in the first place.

## Verify it worked

Log in as a user with both **Administer blocks** and **Administer block css
classes**, go to **Structure → Block layout** (`/admin/structure/block`), and
click **Configure** on any block. You should see three new fields: **Block CSS
class(es)**, **Title CSS class(es)** and **Content CSS class(es)**. See the
[overview](../index.md#how-to-use-it) for how to use them.
