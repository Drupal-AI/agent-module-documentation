# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Bootstrap-based theme**, since the switch uses Bootstrap styling.
- The **Bootstrap Toggle JavaScript library**. Check the module's own `README`
  for whether it bundles the library or expects you to add it to your
  `libraries/` directory, and follow that guidance for your version.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_toggle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_toggle -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_toggle -y
```

After enabling, choose the toggle widget on the boolean fields where you want it —
see [How to use it](../index.md#how-to-use-it) in the overview. There is no
settings form.
