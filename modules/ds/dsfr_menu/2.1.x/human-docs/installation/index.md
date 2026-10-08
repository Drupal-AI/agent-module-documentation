# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **Block** (`block`), **Menu Link (content)**
  (`menu_link_content`), and **Text** (`text`) — these ship with Drupal core.
- **DSFR Core** (`dsfr_core`) — the base of the DSFR suite. Composer pulls it in
  with the command below; it in turn brings DSFR Twig Components, Form Options
  Attributes, and Style Selector.
- Recommended: the base **DSFR theme**, so menus are styled correctly.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dsfr_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in DSFR Core and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dsfr_menu -y
```

Drupal enables DSFR Core and the core dependencies (Block, Menu Link content,
Text) alongside it.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm a DSFR
menu block is available to place. Place it into a region, then view the site to
confirm the menu renders with DSFR styling. See the
["How to use it"](../index.md#how-to-use-it) section for the full workflow.
