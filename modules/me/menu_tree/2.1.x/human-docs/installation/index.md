# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). The 2.x line
  drops support for older core.
- No other modules are required — Menu tree works with core modules only, and there
  are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_tree -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_tree -y
```

Enabling the module makes the tree widget *available*, but it is not switched on
automatically — you turn it on per content type. See
[Configuration](../configuration/index.md).

## Verify it worked

After enabling the module and switching the widget on for a content type (see
Configuration), create or edit a node of that type. Under **Menu settings** on the
node form, the flat "parent link" dropdown should be replaced by a browsable tree
you can expand, collapse, and drag to reorder.
