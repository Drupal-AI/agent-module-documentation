# Installation

## Requirements

Scroll To Top Button is lightweight and has no special requirements:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other Drupal modules are required.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/scroll_top_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scroll_top_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scroll_top_button -y
```

The module ships with the button **turned off**, so nothing will appear on the
front end yet. Head to [Configuration](../configuration/index.md) to switch it on
and choose how it looks.
