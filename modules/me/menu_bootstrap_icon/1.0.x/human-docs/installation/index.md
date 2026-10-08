# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`). The Composer
  package also lists `drupal/core: ^9.3 || ^10 || ^11 || ^12`, but the module's
  own info declares 11/12.
- Core's **Menu UI** module (`menu_ui`) — a dependency for the menu-link icon
  feature.
- The **Parsedown** PHP library (`erusev/parsedown ^1.7.4`) — used to read the
  bundled icon definition files. Composer installs it automatically.

The module bundles the full Bootstrap Icons set (~2,000 icons). It defines no
permissions of its own (the settings page uses core's **Administer site
configuration**), and no Drush commands.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_bootstrap_icon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Parsedown
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_bootstrap_icon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_bootstrap_icon -y
```

This enables the `menu_ui` dependency too if it is not already on.

## Important: enable icons on front-end menus

The icon assets are attached automatically on admin forms and field displays, but
**not** on rendered front-end menus. To make menu icons appear on your site, add
the library to your theme's `.info.yml`:

```yaml
libraries:
  - menu_bootstrap_icon/cdn
```

By default the Bootstrap assets load from a CDN. If your (Bootstrap 5-based) admin
theme already ships them, you can turn the CDN off on the settings page — see the
[overview](../index.md) for the settings page and the rest of the icon features.
