# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** (`file`) and **Responsive Image** (`responsive_image`) modules
  enabled — Drupal enables them automatically as dependencies. The fallback mechanism
  relies on Responsive Image's `<picture>` markup.
- The **GD** PHP extension (`ext-gd`) for the WebP-to-JPEG conversion (or a configured
  ImageMagick toolkit).

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/wpf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/wpf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en wpf -y
```

This enables `file` and `responsive_image` too if they weren't already on.

## Next step

The module needs a WebP-producing responsive image setup to do anything useful, and it
has a small settings page. See [Configuration](../configuration/index.md).
