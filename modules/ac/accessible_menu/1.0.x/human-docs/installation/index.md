# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Menu UI** module (`menu_ui`) — Drupal enables it automatically as a
  dependency when you turn on Accessible Menu.
- No third-party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/accessible_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/accessible_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en accessible_menu -y
```

## Bootstrap 5 submodule — enable only if you need it

If your theme is built on Bootstrap 5, enable the bundled submodule so the
accessible behaviour fits Bootstrap 5 menu markup:

```bash
drush en accessible_menu_bootstrap_5 -y
```

The submodule requires the base Accessible Menu module, which is already present
once you have installed it above. Leave it disabled if you do not use Bootstrap 5.
