# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is a dependency and is part of standard
  Drupal installs.
- A **Bootstrap-based theme** for the output classes to take effect visually.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_layout_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_layout_classes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_layout_classes -y
```

After enabling, there is no settings form to fill in — you configure the widget
and formatter per field under **Manage form display** and **Manage display**. See
[How to use it](../index.md#how-to-use-it) in the overview.
