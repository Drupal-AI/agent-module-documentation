# Installation

## Requirements

Image Effects needs **Drupal core 11.3+** and the following, which Composer pulls
in automatically:

- **File Metadata Manager** (`file_mdm`, `^3.2`) — reads and caches file metadata.
  Image Effects uses two of its submodules:
  - **File metadata EXIF** (`file_mdm_exif`) — supplies EXIF orientation data, used
    by the **Auto Orient** effect.
  - **File metadata font** (`file_mdm_font`) — supplies font metadata, used by the
    **Text Overlay** effect.
- Core's **Image** module (`image`) — provides the image styles that the effects
  are applied on. This ships with Drupal.

Optional but recommended:

- **ImageMagick** (`drupal/imagemagick`, version 5 or higher) — installs the
  ImageMagick image toolkit. Several effects work best (and some, such as the
  **ImageMagick Arguments** effect, only work at all) with the ImageMagick toolkit
  rather than the default GD toolkit.
- **Textimage** (`drupal/textimage`) — caches and reuses rendered text images.
- **Token** (`drupal/token`) — lets you use tokens in the Text Overlay effect's
  text.

## Install with Composer

From the project root:

```bash
composer require drupal/image_effects -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the `file_mdm`
dependency (and its submodules) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_effects -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_effects -y
```

This also enables core's `image` module and the `file_mdm_exif` and
`file_mdm_font` submodules that Image Effects depends on. Once enabled, the
settings page appears under **Configuration → Media → Image Effects settings**
(`/admin/config/media/image_effects`).

## A note on toolkits

Drupal's default image toolkit is **GD**, which handles most of the effects. If you
plan to use effects that GD cannot perform — or you simply want the highest-quality
output — install the **ImageMagick** module and select the ImageMagick toolkit at
**Configuration → Media → Image toolkit** (`/admin/config/media/image-toolkit`).

## Verify it worked

Log in as an administrator and go to
`/admin/config/media/image_effects`. You should see the **Image Effects** settings
page with the **Color selector**, **Image selector**, and **Font selector**
sections. If that page loads, the module is installed correctly. Next, review the
[configuration](../configuration/index.md) and apply your first effect on an image
style.
