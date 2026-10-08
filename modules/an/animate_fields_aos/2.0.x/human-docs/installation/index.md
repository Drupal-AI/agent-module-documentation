# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other Drupal module dependencies. The AOS (Animate On Scroll) JavaScript library is
  used for the effects.

## Install with Composer

From the project root:

```bash
composer require drupal/animate_fields_aos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/animate_fields_aos -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animate_fields_aos -y
```

Once enabled, the per-field animation options appear on the **Manage display** screens.
See [How to use it](../index.md#how-to-use-it) in the overview for the steps.
