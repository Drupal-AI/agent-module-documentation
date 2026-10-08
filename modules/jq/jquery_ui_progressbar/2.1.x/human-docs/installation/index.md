# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** base module (Composer package `drupal/jquery_ui`, `^1.7`) —
  this holds the actual progressbar assets and is a declared dependency, so
  Composer and Drupal pull it in automatically.

There are no other third‑party libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_progressbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `jquery_ui`
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_ui_progressbar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_progressbar -y
```

Enabling the module registers the `jquery_ui_progressbar/progressbar` asset
library. From that point any module or theme can attach it (see the
[main page](../index.md) for how). There is no configuration.

## Submodules

None — jQuery UI Progressbar ships as a single module.
