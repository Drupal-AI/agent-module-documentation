# Installation

## Requirements

Image Style Quality has minimal requirements:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's **Image** module (`image`) enabled — Drupal enables it automatically as a
  dependency when you turn on Image Style Quality.

It also *suggests* (but does not require) the **ImageMagick**
(`drupal/imagemagick`) or **Imagick** (`drupal/imagick`) toolkit modules. You only
need one of those if you want to use that toolkit instead of core's built‑in GD;
the quality effect works with whichever toolkit is active.

## Install with Composer

From the project root:

```bash
composer require drupal/image_style_quality -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/image_style_quality -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_style_quality -y
```

Once enabled, the **Image Style Quality** effect becomes available in the effect
dropdown on every image style. See the
[main guide](../index.md#how-to-use-it) for how to add it to a style and set the
quality value.

This module ships no submodules.
