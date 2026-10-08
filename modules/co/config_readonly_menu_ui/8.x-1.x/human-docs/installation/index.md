# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **[Config Read-only](https://www.drupal.org/project/config_readonly)** (`config_readonly`)
  — the module whose lock this one carves an exception into. It is a hard dependency, and this
  module only makes sense on a site running Config Read-only.
- Core's **Menu UI** (`menu_ui`) and **Menu Link Content** (`menu_link_content`) modules —
  enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_readonly_menu_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the dependencies and update
any shared dependencies as needed. Config Read-only itself is a separate project — require it
too if it is not already in your codebase (`composer require drupal/config_readonly -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_readonly_menu_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_readonly_menu_ui -y
```

Drupal will enable Config Read-only, Menu UI, and Menu Link Content at the same time if they
are not already on.

## Verify it worked

With Config Read-only active (its read‑only mode turned on), go to **Structure → Menus**,
edit a menu that contains content menu links, and confirm you can now reorder those links —
by drag‑and‑drop if the menu has only content links, or via a weight field if it also has a
config‑defined link. If reordering works while the rest of the config lock stays in force,
the module is doing its job. There is no settings form to visit.
