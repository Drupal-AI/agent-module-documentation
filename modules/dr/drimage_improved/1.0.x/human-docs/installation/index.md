# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image** module (`image`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements. Several *optional*
integrations improve Drimage if you already use them — **Focal Point**,
**Image Widget Crop**, **Automated Crop**, and **ImageAPI Optimize WebP** — but
none are required.

## Install with Composer

From the project root:

```bash
composer require drupal/drimage_improved -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drimage_improved -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drimage_improved -y
```

Once enabled, the **Dynamic Responsive Image** formatter becomes available on any
image field's *Manage display* tab. Nothing else is required to start using it —
the global settings ship with sensible defaults.

## Optional submodule — `drimage_s3fs`

If your site stores files on Amazon S3 (via the S3 File System module), Drimage
ships a **`drimage_s3fs`** submodule that adapts on‑the‑fly delivery for
S3‑stored images. Enable it only if you need it:

```bash
drush en drimage_s3fs -y
```

## Verify it worked

Edit an image field's display (**Structure → Content types → *(your type)* →
Manage display**), set its format to **Dynamic Responsive Image**, and view a page
that renders the field. The image should load at roughly the size it occupies on
screen. To fine‑tune behavior, see [Configuration](../configuration/index.md).
