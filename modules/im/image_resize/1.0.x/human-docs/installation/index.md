# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`) and **Image** module (`image`).
- **Recommended:** the ImageMagick toolkit, because it supports the per‑conversion
  **quality** setting that this module can use. GD works too but without that
  quality control.

This release is a **beta** (1.0.0‑beta1) and it modifies original files
irreversibly — make sure you have a **backup** before enabling it on real content.

## Install with Composer

From the project root:

```bash
composer require drupal/image_resize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_resize -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_resize -y
```

## Verify it worked

Go to **Configuration → Media → Image Resizer**
(`/admin/config/media/image-resizer`) — the settings form should load. Do not point
it at production media until you've configured it and tested against a copy with
representative images. See [Configuration](../configuration/index.md).
