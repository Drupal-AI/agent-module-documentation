# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no module dependencies and no third‑party PHP or Composer library
requirements — the toastify‑js JavaScript library is bundled with the module.

- **Optional:** the [jQuery Colorpicker](https://www.drupal.org/project/jquery_colorpicker)
  module — when installed, the Toastify settings form gets a colour‑picker widget
  for the toast colours. Without it, the form falls back to the browser's native
  HTML5 colour input.

## Install with Composer

From the project root:

```bash
composer require drupal/toastify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/toastify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toastify -y
```

There are no submodules. After enabling, grant the **Show toastify messages**
permission and adjust the settings form — see the [main page](../index.md) for the
full walkthrough.
