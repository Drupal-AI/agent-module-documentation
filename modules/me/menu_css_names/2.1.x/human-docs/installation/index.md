# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_css_names -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_css_names -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_css_names -y
```

The module starts working for ordinary menus immediately on enable, and clears
all caches at that point.

## Verify it worked

View your site's front end and inspect a menu in the browser's developer tools.
Each menu item's `<li>` should now carry a CSS class derived from its link text.
If you also want classes on local tasks and actions, see
[Configuration](../configuration/index.md).
