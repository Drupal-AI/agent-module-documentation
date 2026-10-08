# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer libraries, permissions, or settings.

## Install with Composer

From the project root:

```bash
composer require drupal/views_sort_options_weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_sort_options_weight -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_sort_options_weight -y
```

There are no submodules and no settings page. The new "… (set weight)" sort options
appear inside the Views UI — see [the overview](../index.md#how-to-use-it) for the
step-by-step.
