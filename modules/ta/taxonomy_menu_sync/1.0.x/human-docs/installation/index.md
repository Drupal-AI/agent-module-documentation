# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu Link Content** (`menu_link_content`) and **Taxonomy** (`taxonomy`)
  modules — Drupal enables these automatically as dependencies when you turn on
  Taxonomy Menu Sync.

There are no third-party Composer or PHP library requirements. **Menu Item Extras**
is a recommended (but optional) companion if you want extra fields on your menu
items.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_menu_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_menu_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_menu_sync -y
```

## Verify it worked

Enabling the module does not create any menu items yet — you first need to create a
sync configuration. Head to **Structure → Taxonomy Menu Sync**
(`/admin/structure/taxonomy_menu_item_extras`); if you can reach that listing page,
the module is installed and ready to configure. Continue with
[Configuration](../configuration/index.md).
