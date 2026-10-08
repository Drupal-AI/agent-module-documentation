# Installation

## Requirements

Modal Menu Block is lightweight:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Menu** and **Block** systems, which are part of a standard Drupal
  install — there are no contrib module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/modal_menu_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/modal_menu_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modal_menu_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. You should see **Modal Menu Block** in the list of
available blocks. Place it, pick a menu, and save — then visit a front-end page
and confirm the trigger opens the menu in a modal overlay. From here, see the
[main guide](../index.md) for the block configuration steps.
