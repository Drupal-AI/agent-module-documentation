# Installation

## Requirements

This module actually renders PDF pages into images, so it has real server
requirements — check these before installing:

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- **PHP 8.2 or newer** (`php: >=8.2`).
- The **imagick** PHP extension (ImageMagick 6.3.7 or newer). The module enforces
  this at install time — without it, install is blocked.
- The **spatie/pdf-to-image** library, version `^3.0`, installed via Composer (it
  comes in automatically when you require the module with `-W`).
- Core's **Media** module (`media`), enabled as a dependency.

If imagick is not present on your host, install/enable it at the system level (for
example, the `php-imagick` package plus ImageMagick) before enabling the module. In
DDEV, imagick is typically available in the web container already.

## Install with Composer

From the project root:

```bash
composer require drupal/media_pdf_thumbnail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`spatie/pdf-to-image` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_pdf_thumbnail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_pdf_thumbnail -y
```

Core Media is enabled automatically if it is not already on. There are no
submodules.

## Next steps

Enabling the module does not, by itself, change any thumbnails — you have to choose
the **Media PDF Thumbnail Image** formatter on a media type's thumbnail field.
Head to [Configuration](../configuration/index.md) to switch it on and set the page,
format, image style and link options.
