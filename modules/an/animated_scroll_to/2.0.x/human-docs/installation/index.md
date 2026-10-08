# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/animated_scroll_to -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/animated_scroll_to -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animated_scroll_to -y
```

Once enabled, grant the **Administer animated scroll to** permission to the roles that
should manage the settings, then open the settings form to tune duration, offset, and
which elements are affected — see [How to use it](../index.md#how-to-use-it) in the
overview.
