# Installation

## Requirements

Media Thumbnails PDF has a few requirements beyond a normal Drupal module —
because it actually renders PDF pages into images, it needs an image toolkit that
can read PDFs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Media Thumbnails** module (`media_thumbnails`, `^1.0 || ^2.0`) — this is
  the framework the plugin plugs into. Composer pulls it in automatically.
- The **ImageMagick PHP extension** (`ext-imagick`). This is a PHP extension, not
  a Composer package — it must be installed and loaded in your PHP runtime. If it
  is missing, the module reports an error on Drupal's status report and no
  thumbnails are generated.
- In practice, a **Ghostscript** delegate for ImageMagick, so ImageMagick can
  rasterize PDF pages. Without it, ImageMagick can open images but not PDFs.

To confirm the ImageMagick extension is loaded:

```bash
php -m | grep -i imagick
```

If you use DDEV, the web container's PHP includes the `imagick` extension and
Ghostscript; run the check inside the container with `ddev exec php -m | grep -i
imagick`.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnails_pdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the parent Media Thumbnails module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_thumbnails_pdf -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnails_pdf -y
```

Enabling it also enables the parent Media Thumbnails module if it isn't on
already. After enabling, check Drupal's status report
(**Reports → Status report**, `/admin/reports/status`) to confirm ImageMagick is
detected — if the module shows an error there, install/enable the `imagick` PHP
extension and Ghostscript before expecting thumbnails.

There is no configuration step for this module. From now on, saving a PDF media
entity generates its first-page thumbnail automatically. To adjust the thumbnail
width, see the parent module's settings, described in the
[overview](../index.md#how-to-use-it).
