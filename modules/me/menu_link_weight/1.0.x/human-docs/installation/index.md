# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu UI** (`menu_ui`) and **Node** (`node`) modules — Drupal enables
  them automatically as dependencies.

There are no third-party Composer or PHP library requirements. The optional
**Client-side hierarchical select** (`drupal/cshs`) module is only needed if you
want the `cshs` parent-selector option (see the main guide).

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_link_weight -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_weight -y
```

That is all. The drag-and-drop weight widget now appears on menu-link forms and
in the node edit form's Menu settings. There is no required configuration — the
only optional setting (the parent selector) is covered in the main guide.
