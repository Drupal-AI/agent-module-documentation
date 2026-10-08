# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules —
  Drupal enables them as dependencies.
- A **JW Player account** with videos, so you have JW media IDs to add.

There are no PHP library requirements; the module fetches video metadata from JW's
public CDN endpoint at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/jw_video_media_source -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jw_video_media_source -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jw_video_media_source -y
```

Or enable **JW player media source for media library** on the **Extend** page
(`/admin/modules`).

## Verify it worked

Go to **Structure → Media types → Add media type** (`/admin/structure/media/add`).
If the module is installed, **JW Player** appears as an available media source.
Create a media type with it, then add a video through the Media Library by pasting a
JW Player media ID — the video's title, thumbnail, and metadata should populate
automatically.

> **Heads up:** This release is not covered by Drupal's security advisory policy.
