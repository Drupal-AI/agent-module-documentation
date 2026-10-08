# Installation

## Requirements

Background Image Formatter is lightweight:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1.0 or newer** (`php: >=8.1.0`).
- Core's **Image** module (`image`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on Background Image Formatter.

There are no other third-party Composer or PHP library requirements. The
[Token](https://www.drupal.org/project/token) module is an optional extra — if it
is installed, the formatter's custom link URL can use tokens — but it is not
required.

## Install with Composer

From the project root:

```bash
composer require drupal/background_image_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/background_image_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en background_image_formatter -y
```

That's all it takes. The two **Background Image** formatters are now available to
choose on image and media-reference fields. See the
[overview](../index.md#how-to-use-it) for how to apply one on a field's Manage
display tab.
