# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Text** module (`text`), enabled automatically as a dependency — it
  provides the textarea widgets this module makes available.

There are no third‑party libraries, no settings page, and no permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/textarea_widget_for_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/textarea_widget_for_text -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en textarea_widget_for_text -y
```

There are no submodules. Once enabled, the **Text area (multiple rows)** widget
becomes selectable for short `string` and single‑line `text` fields on the *Manage
form display* page — see [How to use it](../index.md#how-to-use-it).
