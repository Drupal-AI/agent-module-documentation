# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Menu Link Content** module (`menu_link_content`) — enabled
  automatically as a dependency when you turn this module on.
- No third‑party PHP or JavaScript libraries.

Optionally, this module pairs well with
[Menu Admin per Menu](https://www.drupal.org/project/menu_admin_per_menu): when
that module is present, Menu Level Permission falls back to its per‑menu
permissions for links that are *not* in a restricted level.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_level_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_level_permission -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_level_permission -y
```

## Verify it worked

Enabling the module alone changes nothing yet — it only takes effect once you
choose the menus and depth to protect. Log in as an administrator, go to
**Configuration → User interface → Menu level permissions**
(`/admin/config/user-interface/menu-level-permissions`), and confirm the settings
form appears. Then head to [Configuration](../configuration/index.md) to set it up.
