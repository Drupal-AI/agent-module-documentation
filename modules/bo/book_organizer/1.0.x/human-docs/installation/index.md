# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Book** module (`book`) — Drupal enables it as a dependency when you
  turn on Book Organizer. You will need at least one book built with core Book to
  organize.

There are no third‑party Composer or PHP library requirements. The module
provides its own permission for controlling who may reach the overview.

## Install with Composer

From the project root:

```bash
composer require drupal/book_organizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book_organizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book_organizer -y
```

After enabling, grant the module's permission to the appropriate roles under
**People → Permissions**, then open the Views‑powered book overview — see
[How to use it](../index.md#how-to-use-it).
