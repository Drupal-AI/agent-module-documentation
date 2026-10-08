# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- Core's **Book** (`book`) and **Node** (`node`) modules — Drupal enables them as
  dependencies when you turn on Book Access Code. You will need at least one book
  built with core Book to protect.

There are no third‑party Composer or PHP library requirements. The module
provides its own permissions, including *administer access codes* and *bypass
book access code checks*.

## Install with Composer

From the project root:

```bash
composer require drupal/book_access_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book_access_code -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book_access_code -y
```

## Next steps

Once enabled, create access codes for your books and set the access‑page text —
see [Configuration](../configuration/index.md). Remember that the gate only
covers the normal book page view, not JSON:API/REST/Views.
