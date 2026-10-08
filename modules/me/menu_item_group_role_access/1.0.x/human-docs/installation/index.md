# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Menu Link Content** (`menu_link_content`) and **Menu UI** (`menu_ui`)
  modules — enabled automatically as dependencies.
- The contributed **[Group](https://www.drupal.org/project/group)** module
  (`group`) — this module works against Group roles, so Group must be installed
  and set up (with groups and group roles) for the role options to be meaningful.

There are no third‑party Composer or PHP library requirements. The module sits in
the Menu package.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_item_group_role_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — it will pull in the Group module if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_item_group_role_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_item_group_role_access -y
```

## Verify it worked

Make sure the Group module is set up with at least one group type and some group
roles. Then go to **Structure → Menus** (`/admin/structure/menu`), edit a menu
link, and confirm you see the role field this module adds (listing your available
group roles). See [Configuration](../configuration/index.md) for how to use it.
