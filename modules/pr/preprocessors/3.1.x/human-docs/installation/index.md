# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no dependent
modules.

> **Before you install:** on Drupal 11.2+ (Preprocess Hook Attributes) and 11.3+
> (OOP theme hooks), the equivalent capability is in core and this module is no
> longer recommended. It remains useful on earlier versions or when you
> specifically want plugin classes inside a theme. It is minimally maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/preprocessors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/preprocessors -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preprocessors -y
```

## Verify it worked

Add a `MY_THEME.preprocessors.yml` file and a matching plugin class to your theme
(see "How to use it" in the [overview](../index.md)), clear caches (`drush cr`),
and confirm the variable your `preprocess()` method sets is available in the
target template. If it is, the module is discovering and running your preprocessor
plugins.
