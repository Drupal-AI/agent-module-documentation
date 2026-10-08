# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A **Bootstrap-based theme**, since the widget uses Bootstrap styling.
- The **bootstrap-select JavaScript library**. Check the module's own `README`
  for whether it bundles the library or expects you to place it in your
  `libraries/` directory, and follow that guidance for your version.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_select -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_select -y
```

After enabling, choose the bootstrap-select widget on the option fields where you
want it — see [How to use it](../index.md#how-to-use-it) in the overview. There is
no settings form.
