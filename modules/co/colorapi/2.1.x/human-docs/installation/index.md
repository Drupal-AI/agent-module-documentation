# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

- *Optional but recommended:* the **jQuery Colorpicker** module
  (`drupal/jquery_colorpicker`) if you want a real color‑picker widget for the
  Color field. Without it, the field's widget is plain text inputs for the name and
  hex value.

## Install with Composer

From the project root:

```bash
composer require drupal/colorapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional picker:

```bash
composer require drupal/jquery_colorpicker -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colorapi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorapi -y
```

Out of the box the **Color field** is enabled and the **Color entity** is disabled.
You can change both on the settings form — see [How to use
it](../index.md#how-to-use-it) in the overview.

## Submodules

Color API ships no submodules.
