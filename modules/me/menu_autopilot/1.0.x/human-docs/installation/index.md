# Installation

## Requirements

- **Drupal 10.6+ or Drupal 11** (`core_version_requirement: ^10.6 || ^11`).
- Core's **Menu Link Content** (`menu_link_content`) and **Node** (`node`)
  modules — both enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements. The
[Token](https://www.drupal.org/project/token) module is a useful companion if you
want a token browser when building child link labels.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_autopilot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_autopilot -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_autopilot -y
```

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`), edit any top-level menu
link, and confirm you see a **Menu Autopilot: children of …** section on the
link's edit form. If it is there, the module is installed — continue to
[Configuration](../configuration/index.md) to point it at a content source.
