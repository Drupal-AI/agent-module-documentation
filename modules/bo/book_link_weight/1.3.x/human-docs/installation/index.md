# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Book** module (`book`) — Drupal enables it as a dependency when you
  turn on Book Link Weight.

There are no third‑party Composer or PHP library requirements, and the module
adds no routes, permissions or configuration of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/book_link_weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book_link_weight -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book_link_weight -y
```

That's all it takes. The next time you edit a book page, the outline ordering is a
drag‑and‑drop table — see [How to use it](../index.md#how-to-use-it). There is no
configuration.
