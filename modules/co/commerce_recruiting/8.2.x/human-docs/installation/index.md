# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Cart** (`commerce_cart`) from the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite, which pulls in
  the rest of Commerce as needed.

There are no additional PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_recruiting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_recruiting -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_recruiting -y
```

## Verify it worked

Under **Commerce**, confirm you can create a recruiting **campaign**, and check
that the recruiting **blocks** are available in **Structure → Block layout**. Then
follow the workflow in the [overview](../index.md) to set up your first campaign.
