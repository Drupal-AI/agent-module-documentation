# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Options** module (`options`) — provides the select values for todo
  status.
- Core's **History** module (`history`) — used to track todo state.

Both are core modules and are enabled automatically as dependencies. There are no
third‑party Composer or PHP library requirements. Note this module's security
advisory coverage is *not covered*, so review it before using it on a production
site.

## Install with Composer

From the project root:

```bash
composer require drupal/contrib_todo_list -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contrib_todo_list -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contrib_todo_list -y
```

## Finish setup

Two manual steps make the feature usable:

1. **Grant the permission** — at **People → Permissions**, give the **Manage todo
   list** permission to the roles that should manage todos.
2. **Place the block** — at **Structure → Block layout**, place the **Contrib
   todo list** block in a theme region.

## Verify it worked

Visit any node page as a user with the *Manage todo list* permission. The Contrib
todo list block should appear, letting you add a todo, share it, and set its
status.
