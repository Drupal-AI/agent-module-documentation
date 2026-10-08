# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No hard module dependencies and no Composer/PHP library requirements for the base
  module.
- **Optional integrations:** the **Webform** module (only if you enable the
  `css_toggle_switch_webform` submodule) and **Better Exposed Filters** (if you
  want toggle switches on exposed View filters).

## Install with Composer

From the project root:

```bash
composer require drupal/css_toggle_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/css_toggle_switch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en css_toggle_switch -y
```

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Webform integration** | `css_toggle_switch_webform` | Lets you render Webform boolean/checkbox elements as CSS toggle switches. Enable it only if you use the **Webform** module. |

Enable it when you need it:

```bash
drush en css_toggle_switch_webform -y
```

## Verify it worked

With the module enabled, render a boolean control through one of its integration
points — a Better Exposed Filters checkbox on a View, or (with the submodule
enabled) a Webform checkbox element — and confirm it displays as a sliding toggle
switch that you can operate with the keyboard. See the
[main guide](../index.md#how-to-use-it) for where the toggle applies.
