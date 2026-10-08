# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core modules **Editor**, **CKEditor 5**, **Options** and **Views** — Drupal
  enables these automatically as dependencies.
- Contributed modules **Markdown** (`drupal/markdown`) and **Color Field**
  (`drupal/color_field`), plus CKEditor mentions support for user tagging. The
  Composer command below pulls these in for you.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/minikanban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
shared dependencies (Markdown, Color Field, and so on) that MiniKanban needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/minikanban -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en minikanban -y
```

Enabling MiniKanban also enables its required core and contributed modules.

## Verify it worked

Log in as an administrator and visit **`/kanban`** — you should see the board
interface. Its settings page is available at **Configuration → Workflow →
MiniKanban** (`/admin/config/workflow/minikanban`). Remember to grant the
MiniKanban permissions under **People → Permissions** to the roles that should be
able to use the board.
