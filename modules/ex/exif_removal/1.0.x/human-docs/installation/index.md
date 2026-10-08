# Installation

## Requirements

- **Drupal 10.3 or newer, or 11** (`core_version_requirement: ^10.3||^11`).
- PHP's **GD** image library, which is part of a standard PHP install and is what
  Drupal typically uses as its image toolkit. EXIF Removal uses it to re‑encode
  JPEGs and strip their metadata.
- *Optional:* the [Image Effects](https://www.drupal.org/project/image_effects)
  module together with the **ImageMagick** toolkit — if present, EXIF Removal uses
  ImageMagick's `strip` operation instead of GD.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/exif_removal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exif_removal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exif_removal -y
```

That's the entire setup. There is no configuration form — from now on the module
strips EXIF metadata from images uploaded through any Drupal form.

## Verify it worked

Upload a photo you know contains EXIF data (a picture straight from a phone, with
GPS location, is ideal) through any image field. Download the stored file and
inspect its metadata — the GPS, camera, and timestamp fields should be gone, while
the image itself looks the same.
