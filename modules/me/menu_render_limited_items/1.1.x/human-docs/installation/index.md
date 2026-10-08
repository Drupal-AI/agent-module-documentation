# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) and **Menu UI** module (`menu_ui`) — both are
  listed as dependencies and Drupal enables them automatically when you turn this
  module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_render_limited_items -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_render_limited_items -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_render_limited_items -y
```

## Verify it worked

Enabling the module does not change anything by itself. To make it work you must
**replace a core menu block with the block this module provides** and set its
render limit — see "How to use it" on the [overview page](../index.md). Once you
have placed the block and set a limit, load a page that shows that menu and confirm
only the first N top‑level items appear while the rest remain in **Structure →
Menus**.
