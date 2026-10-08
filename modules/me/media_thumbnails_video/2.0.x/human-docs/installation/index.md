# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Media Thumbnails** framework module (`drupal/media_thumbnails`, 2.0 or
  newer) — the framework this module plugs into. Drupal enables it as a
  dependency.
- The **`php-ffmpeg/php-ffmpeg`** PHP library (0.14.0 or newer) — pulled in
  automatically when you install with Composer.
- PHP's **GD** extension (`ext-gd`), used to write the PNG thumbnail.
- A working **FFmpeg** installation on the server — the `ffmpeg` and `ffprobe`
  binaries. These are system tools, not Composer packages, so they must be
  installed on the host (for example via your OS package manager or your DDEV
  configuration). Without them, no thumbnails are generated.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer also downloads the required `php-ffmpeg`
library and pulls in the Media Thumbnails framework.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_thumbnails_video -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.
> DDEV's web image already includes the FFmpeg binaries, so `ffmpeg`/`ffprobe`
> are typically available inside the container without extra setup.

## Enable the module

```bash
drush en media_thumbnails_video -y
```

Enabling Media Thumbnails Video pulls in the Media Thumbnails framework. Next,
confirm FFmpeg is reachable and adjust the settings if needed — see
[Configuration](../configuration/index.md).

This module ships no submodules and adds no permissions of its own (the settings
form uses core's **Administer site configuration**).
