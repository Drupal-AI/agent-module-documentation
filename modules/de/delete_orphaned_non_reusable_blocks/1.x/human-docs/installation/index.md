# Installation

> **Before you install:** this module **deletes orphaned inline block content**
> and the deletion is **irreversible**. The module's own documentation says it
> **should not be run on production** and that you should **back up the database
> first**. Review the warnings in the [overview](../index.md) before using it.

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A site using **Layout Builder** (core) with inline/non‑reusable blocks — that
  is the content this tool operates on.

There are no other module dependencies, and no PHP library or third‑party
Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/delete_orphaned_non_reusable_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/delete_orphaned_non_reusable_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en delete_orphaned_non_reusable_blocks -y
```

Then clear caches:

```bash
drush cr
```

## Verify it worked

Go to **Content → Content authoring → Delete Orphaned Block Content**. If the
screen loads and reports on orphaned blocks, the module is active. Do **not**
confirm any deletion until you have taken a backup, are working on a
non‑production environment, and have reviewed what it proposes to remove — see the
[overview](../index.md) for the full workflow and warnings.
