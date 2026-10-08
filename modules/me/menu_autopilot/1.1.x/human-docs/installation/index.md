# Installation

## Requirements

- **Drupal 10.6+ or Drupal 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- **PHP 8.1 or newer.**
- Core's **Menu Link Content** (`menu_link_content`) and **Node** (`node`)
  modules — both enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements. The
[Token](https://www.drupal.org/project/token) module is a recommended companion —
it adds the token-browser UI and extra tokens for the child link title pattern.

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

Visit the settings page at **Structure → Menu Autopilot**
(`/admin/structure/menu/autopilot`) and confirm it loads — by default the
**main** menu is managed. Then edit any menu link under **Structure → Menus** and
confirm you see an **Automatic children** section on its edit form. If both are
present, the module is installed — continue to
[Configuration](../configuration/index.md).
