# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8** (`php_requirement: 8.x`).
- No contrib dependencies — it uses only core's `file` and `filter` modules, which
  are already enabled on a standard site.

## Install with Composer

From the project root:

```bash
composer require drupal/convert_media_tags_to_markup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/convert_media_tags_to_markup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en convert_media_tags_to_markup -y
```

There is no configuration form. Once enabled, either add the **"Convert Legacy
Media Tags to Markup"** filter to a text format, or run the one-time Drush
conversion — both are described on the [overview page](../index.md#how-to-use-it).
