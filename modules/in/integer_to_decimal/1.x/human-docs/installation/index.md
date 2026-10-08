# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3.0 || ^11`).
- Core's **Node** module (`node`) — this version converts fields on nodes, and
  Drupal enables Node automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

> **Back up first.** This module rewrites field storage. Before converting any
> field, take a full database backup and, ideally, work in a maintenance window.

## Install with Composer

From the project root:

```bash
composer require drupal/integer_to_decimal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/integer_to_decimal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en integer_to_decimal -y
```

## Verify it worked

Go to **Structure → Content types → *(a content type)* → Manage fields**, edit an
integer field that has data, and open its **Field settings** tab. If you see the
**Enable integer to decimal conversion** option, the module is installed and ready.
Follow the steps in the [overview](../index.md#how-to-use-it) to perform the
conversion — after backing up your database.
