# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.
- No third-party libraries and no other contributed modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_submenu_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_submenu_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_submenu_block -y
```

Enabling it also enables core's Block module if it isn't already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. In the block picker you should see an Entity Submenu block
for each of your menus (labeled with the menu name and "(Entity Submenu Block)").
Place one for a menu that has nested items, configure a view mode for `node`
(e.g. *Teaser*), then visit a page that has child menu items and confirm the
children render as entities rather than plain links.

There is no separate settings page to configure — all options live on each block
you place. See "How to use it" in the [overview](../index.md) for the block
settings.
