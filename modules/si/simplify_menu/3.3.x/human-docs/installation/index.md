# Installation

## Requirements

Simplify Menu is a pure helper with no dependencies beyond core:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules, PHP libraries, or Composer requirements — it builds
  entirely on core's menu link tree.

## Install with Composer

From the project root:

```bash
composer require drupal/simplify_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplify_menu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplify_menu -y
```

There are no submodules, no settings form, and nothing to configure. As soon as
the module is enabled, the `simplify_menu()` Twig function and the
`simplify_menu.menu_items` service are available — see
[the index page](../index.md#how-to-use-it) for how to call them.
