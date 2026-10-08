# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements — the Animate.css
integration ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_animate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_animate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_animate -y
```

Alternatively, enable it from **Extend** (`/admin/modules`) in the admin UI.

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`), edit any menu link, and
confirm you see a **Menu Animate** section on the link's configuration form. Pick
an animation, save, and view the menu on the front end to confirm the effect
runs. See the [overview](../index.md#how-to-use-it) for the per-link workflow.
