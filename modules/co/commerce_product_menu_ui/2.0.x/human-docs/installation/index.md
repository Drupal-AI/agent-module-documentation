# Installation

## Requirements

Commerce Product Menu UI is a thin bridge, so its requirements are just the pieces
it bridges:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce** (`commerce`) and the **Commerce Product** submodule
  (`commerce_product`) — the product form this module extends.
- Core's **Menu UI** module (`menu_ui`) — the menu-link behaviour it reuses.

Drupal will pull in these dependencies automatically when you enable the module.
There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_menu_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_menu_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_menu_ui -y
```

That's all it takes. The menu-link section is available on the product form
immediately.

## Verify it worked

Edit any Commerce product. You should now see a **Menu settings** section on the
form — the same "Provide a menu link" control that nodes have. Tick it, save, and
confirm the product appears in your chosen menu.
