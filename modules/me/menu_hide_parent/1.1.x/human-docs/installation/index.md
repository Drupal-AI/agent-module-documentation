# Installation

## Requirements

- **Drupal 10.4+ or Drupal 11** (`core_version_requirement: ^10.4 || ^11`).

There are no other module dependencies, and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_hide_parent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_hide_parent -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_hide_parent -y
```

## Verify it worked

Go to **Configuration → User interface → Menu Hide Parent**
(`/admin/config/user-interface/menu-hide-parent`) and confirm the settings form
loads with a list of your menus to choose from. Enable it for a menu that has an
empty placeholder parent, then view that menu as a user who cannot reach the
children — the empty parent should no longer appear. See
[Configuration](../configuration/index.md) for details.
