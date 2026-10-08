# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **[Media Thumbnails](https://www.drupal.org/project/media_thumbnails)** 1.x or
  2.x (`drupal/media_thumbnails`) — the framework this module extends. Composer
  installs it as a dependency.
- The **`meyfa/php-svg`** PHP library (`^0.12.0`), which provides the pure‑PHP
  rasterization fallback. Composer installs it automatically.

For the best output quality, install **GraphicsMagick** (the `gm` binary) or
**ImageMagick** (the `convert` binary) on the server. Neither is required — the
module falls back to PHP's GD extension with `meyfa/php-svg` when no CLI tool is
present — but a CLI rasterizer produces noticeably better thumbnails. After
installing, check *Reports → Status report* to see which one the module detected.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_svg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in both Media Thumbnails and the
`meyfa/php-svg` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_thumbnails_svg -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails_svg -y
```

Drush enables Media Thumbnails automatically if it is not already on. There is no
configuration step for this module itself — once it's enabled, upload an SVG to
an SVG‑capable media type and the thumbnail is generated for you. See the
[overview](../index.md) for how to allow SVG uploads and where the width and
background settings live.

## Submodules

Media Thumbnails SVG ships no submodules.
