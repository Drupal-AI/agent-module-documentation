# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules, PHP extensions or third-party Composer libraries are required.

The module ships its own compiled CSS (desktop and mobile) and JavaScript, so
there is nothing to build for normal use. (If you want to restyle the widget, the
SCSS source lives in the module's `misc/` folder and would need recompiling, or you
can override the library in your theme.)

## Install with Composer

From the project root:

```bash
composer require drupal/accessibility_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/accessibility_menu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en accessibility_menu -y
```

Then choose what the widget offers and place it — see
[Configuration](../configuration/index.md).
