# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Layout Builder** (`layout_builder`) — this is the module it extends.
- Other core modules it builds on: **Block** (`block`), **Block Content**
  (`block_content`), **Node** (`node`), and **Views** (`views`). Drupal enables
  these as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_ajax_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_ajax_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_ajax_blocks -y
```

Drupal will enable Layout Builder and the other required core modules as
dependencies.

## Verify it worked

Edit a Layout Builder layout, add or configure a block, and confirm an **"Enable
Ajax for this block."** checkbox now appears in the block configuration form. Tick
it, save the block and the layout, then load the page and watch the block resolve
via Ajax — see the overview's "How to use it".
