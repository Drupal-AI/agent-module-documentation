# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Elevate Zoom JavaScript library**, downloaded manually (see below). The
  zoom effect will not work until this library is in place.

There are no other module dependencies.

> **Note:** This project's security advisory coverage is marked *not covered* by
> the Drupal Security Team. Weigh that before using it on a high‑value production
> site.

## Install with Composer

From the project root:

```bash
composer require drupal/elevate_image_zoom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elevate_image_zoom -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Download the Elevate Zoom library

The module relies on the third‑party Elevate Zoom library, which is not shipped
with it:

1. Download the Elevate Zoom library.
2. Place it in your site's libraries directory at `/libraries/elevatezoom`.

Do this **before** (or right after) enabling the module — without the library the
formatter renders images normally but adds no zoom.

## Enable the module

```bash
drush en elevate_image_zoom -y
```

## Verify it worked

Apply the Elevate Image Zoom formatter to an image field on a content type's
**Manage display** page (see the [main guide](../index.md)), then view a piece of
content that uses that field. Hovering over the image should show a magnified
view. If nothing happens, re‑check that the library is in `/libraries/elevatezoom`
and clear the cache with `drush cr`.
