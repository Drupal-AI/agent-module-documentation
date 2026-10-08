# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Link** (`link`) and **Menu link content** (`menu_link_content`)
  modules — these power the menu-to-UIkit-component rendering and are enabled
  automatically as dependencies.
- The **UIkit base theme** to actually get value from the module. It is not a hard
  Composer dependency, but without it the module's components have no matching
  CSS/JS to render against.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/uikit_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/uikit_components -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en uikit_components -y
```

Make sure the **UIkit base theme** (or a subtheme of it) is installed and set as
your default or admin theme, otherwise the components have nothing to style
against. Once both are in place you can configure the module and start rendering
menus as UIkit components — see [Configuration](../configuration/index.md).

There are no submodules.
