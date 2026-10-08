# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Block** module (`block`), enabled automatically as a dependency.
- The contrib **CTools** module (`drupal/ctools`, `^3.15 || ^4.1`), which Composer
  installs for you.

Two optional companions are worth knowing about:

- **Page Manager UI** (`page_manager_ui`) — a submodule shipped with this project
  that provides the Structure → Pages wizard. Without it, the module is API-only and
  you would have to write page config by hand, so on most sites you enable it.
- **Panels** (`drupal/panels`) — a separate contrib module that adds a drag-and-drop
  layout variant. Install it only if you want Panels layouts.

## Install with Composer

From the project root:

```bash
composer require drupal/page_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in CTools automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_manager -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the engine and — on almost every site — the UI submodule together:

```bash
drush en page_manager page_manager_ui -y
```

This enables CTools and core Block as dependencies too. With `page_manager_ui` on,
the **Structure → Pages** wizard becomes available.

## Grant the permission

Managing pages is gated by the **Administer pages** (`administer pages`) permission.
Grant it only to trusted administrative roles, since a Page Manager page can take
over core routes:

```bash
drush role:perm:add administrator 'administer pages'
```

## Next step

Head to [Configuration](../configuration/index.md) to build your first page and its
variants.
