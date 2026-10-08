# Installation

## Requirements

Asymmetric Menu Trees needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A multilingual site — the module is only meaningful once you have more than one
  language enabled (core's Language / Content Translation features).

There are no module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/asymmetric_menu_trees -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/asymmetric_menu_trees -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en asymmetric_menu_trees -y
```

There is no configuration form. Once enabled, edit your menus at **Structure →
Menus** and build a different structure per language as needed — see the
[overview guide](../index.md#how-to-use-it).
