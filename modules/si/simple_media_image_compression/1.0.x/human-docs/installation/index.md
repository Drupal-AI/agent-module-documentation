# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- PHP's **GD** image library, which does the actual JPEG re‑encoding. GD is a standard
  part of most PHP installations and is what Drupal core commonly uses for image
  processing.
- No dependent Drupal modules and no third‑party Composer packages.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_media_image_compression -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_media_image_compression -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_media_image_compression -y
```

## Verify it worked

After enabling, go to **Configuration → System → Simple Media Image Compression**. If
the settings form loads, the module is installed. Nothing is compressed until you tick
**Enable Compression**, set a quality, and then save (or re‑save) content that
references media images — see [Configuration](../configuration/index.md), and note the
warning there that compression overwrites the original file with no backup.
