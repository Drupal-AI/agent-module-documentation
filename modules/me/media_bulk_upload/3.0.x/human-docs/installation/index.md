# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) enabled — Drupal enables it automatically as a
  dependency.
- The **DropzoneJS** module (`drupal/dropzonejs`, `^2.0`), which Composer installs
  as a dependency of this module. (The base upload form uses a plain file field;
  DropzoneJS is only *required* as a dependency because the optional DropzoneJS
  sub‑module builds on it.)

Before creating configurations, make sure you have at least one **media type** set
up (Image, Document, etc.) with its source file/image field, since the upload form
derives its allowed extensions and size limits from the media types you select.

## Install with Composer

From the project root:

```bash
composer require drupal/media_bulk_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in DropzoneJS and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_bulk_upload -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_bulk_upload -y
```

## Submodule — DropzoneJS drag‑and‑drop uploader

The project ships one optional sub‑module, **`media_bulk_upload_dropzonejs`**, which
replaces the plain multi‑file field on the upload form with a DropzoneJS
drag‑and‑drop area. Enable it if you want that experience:

```bash
drush en media_bulk_upload_dropzonejs -y
```

## Next step

Continue to [Configuration](../configuration/index.md) to create your first
bulk‑upload configuration and grant the permission that lets editors use it.
