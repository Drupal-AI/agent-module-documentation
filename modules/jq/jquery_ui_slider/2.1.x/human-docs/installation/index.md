# Installation

## Requirements

jQuery UI Slider is a small library shim. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The base **jQuery UI** module (`jquery_ui`, `^1.7`) — this is the only
  dependency, and it provides the underlying jQuery UI files. Composer and Drupal
  pull it in automatically when you install this module.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the required
`drupal/jquery_ui` package (and update any shared dependencies) for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_ui_slider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_slider -y
```

Drupal enables the base `jquery_ui` module at the same time if it isn't already
on. As soon as it is enabled the slider library is available for any module or
theme to depend on or attach — there is no required configuration and no settings
form to visit.
