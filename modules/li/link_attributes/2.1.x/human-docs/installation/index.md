# Installation

## Requirements

Link attributes is small and has few requirements:

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- **PHP 8.0 or newer**.
- Core's **Link** module (`link`) enabled — this is the only dependency, and Drupal
  enables it automatically when you turn on Link attributes.

There are no third‑party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/link_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_attributes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_attributes -y
```

Enabling the module makes the **Link (with attributes)** widget available; it does
not change any existing fields until you switch a field to that widget (see
[Configuration](../configuration/index.md)).

## Submodules — enable only what you need

Link attributes ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Menu link attributes** | `link_attributes_menu_link_content` | Brings the same attribute inputs to content menu links, so you can set `target`, `rel`, `class`, etc. on menu items. |
| **Linkit attributes** | `linkit_attributes` | Combines the attribute panel with the Linkit autocomplete widget, so editors get both content autocompletion and attribute control. |

For example, to add attributes to menu links:

```bash
drush en link_attributes_menu_link_content -y
```

Each submodule builds on the base Link attributes module, which is already present
once you have installed it above.
