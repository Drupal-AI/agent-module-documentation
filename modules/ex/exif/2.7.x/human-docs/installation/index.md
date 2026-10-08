# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **File**, **Image**, and **Taxonomy** modules — enabled automatically
  as dependencies.
- A metadata backend on the server (choose one on the settings page):
  - The PHP **`exif`** and **`iptcparse`** extensions (the default; usually
    present in a standard PHP build), **or**
  - An external **`exiftool`** binary, which exposes many more tags (including
    GPS). If you want to use this backend, install ExifTool on the server and
    note its path.
- For **GPS** data specifically, use **ImageMagick** as Drupal's image toolkit —
  the GD toolkit strips GPS tags when generating image derivatives.

There are no third‑party Composer PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/exif -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/exif -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exif -y
```

Or enable **Exif** from **Extend** (`/admin/modules`). File, Image, and Taxonomy
are enabled at the same time if they are not already on.

There are no submodules. Continue to [Configuration](../configuration/index.md)
to choose a backend, enable the bundles you want scanned, and add fields.
