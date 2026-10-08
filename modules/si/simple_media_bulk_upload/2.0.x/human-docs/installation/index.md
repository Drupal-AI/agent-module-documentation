# Installation

## Requirements

Simple Media Bulk Upload needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Media** system (media types with file‑based sources — image, file,
  video, audio).
- The **DropzoneJS** module (`dropzonejs`) — this provides the drag‑and‑drop upload
  widget and is a required dependency, so Composer and Drupal pull it in for you.
  DropzoneJS also defines the `dropzone upload files` permission the bulk form uses.

There are no other third‑party Composer libraries or special PHP extensions to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_media_bulk_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and brings in DropzoneJS.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_media_bulk_upload -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_media_bulk_upload -y
```

Drupal enables `dropzonejs` at the same time as a dependency.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Grant your account the **`dropzone upload files`** permission, then go to
**Content → Media → Bulk upload** (`/admin/content/media/bulk-upload`). You should
see a media‑type picker followed by a drag‑and‑drop area. Next, see
[Configuration](../configuration/index.md) to set how many files can be dropped at
once and who is allowed to use the form.
