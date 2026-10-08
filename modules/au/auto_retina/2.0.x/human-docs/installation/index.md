# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No contrib module dependencies and no third-party Composer or PHP library
  requirements. Image derivatives are produced through Drupal's normal image
  toolkit.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_retina -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_retina -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_retina -y
```

Once enabled, open the Auto Retina settings form and choose which image styles
should get retina derivatives, as described on the [overview
page](../index.md).
