# Installation

## Requirements

Taxonomy Menu UI has no third-party libraries and builds entirely on core modules:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`).
- Core's **Menu UI** module (`menu_ui`).

Both are enabled automatically as dependencies.

The optional [Menu Admin per Menu](https://www.drupal.org/project/menu_admin_per_menu)
module works nicely alongside it — if present, editors who administer a specific menu
(rather than holding the site-wide "Administer menus" permission) can also add term
links to that menu.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_menu_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_menu_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_menu_ui -y
```

There are no submodules and no central settings form. Continue to
[Configuration](../configuration/index.md) to allow menus on a vocabulary.

## Verify it worked

Go to **Structure → Taxonomy**, edit a vocabulary
(`/admin/structure/taxonomy/manage/<vocabulary>`), and look in the vertical tabs at the
bottom. You should now see a **Menu settings** tab that wasn't there before.
