# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third-party Composer or PHP library requirements — the module ships the
  Bootstrap Tour library assets itself under its `assets/` folder and declares
  them as a front-end library.

## Install with Composer

From the project root:

```bash
composer require drupal/bs_tour -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bs_tour -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bs_tour -y
```

Once enabled, define your tour steps and place the tour block — see
[Configuration](../configuration/index.md).
