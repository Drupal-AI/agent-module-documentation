# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Image** and **Field** modules (part of a standard Drupal install).

There are no other module dependencies and no third‑party Composer or PHP library
requirements — it is a single, lightweight formatter plugin.

## Install with Composer

From the project root:

```bash
composer require drupal/avatar_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/avatar_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en avatar_field_formatter -y
```

The module has no settings form. To use it, go to an image field's **Manage
Display** tab and select the **Avatar** formatter — see
[How to use it](../index.md#how-to-use-it) on the overview page.
