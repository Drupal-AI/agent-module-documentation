# Installation

## Requirements

Media Gallery builds on Drupal core's Media system plus one third‑party JavaScript
library. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Text** (`text`) and **Media Library** (`media_library`) modules — both
  ship with Drupal and are enabled automatically as dependencies.
- The **PhotoSwipe** module (`drupal/photoswipe`, `^5.0`), which provides the
  lightbox. Composer installs it for you when you require Media Gallery.

## Install with Composer

From the project root:

```bash
composer require drupal/media_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the PhotoSwipe
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_gallery -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_gallery -y
```

Enabling it also turns on Text, Media Library, and PhotoSwipe if they are not
already on. The module ships defaults — a 300×180 "Media Gallery Image" image style,
a "Full gallery" view mode, and the "All Galleries" View at `/galleries` — so you
can start creating galleries right away.

## Optional migration submodules

Two submodules help you import galleries from a legacy Drupal 7 site. Enable one
only if you are migrating:

| Submodule | Machine name | Use it for |
|-----------|--------------|------------|
| **Media Gallery Migration** | `media_gallery_migration` | Importing galleries from Drupal 7 **Media 7.x‑1.x** |
| **Media Gallery Migration 2** | `media_gallery_migration2` | Importing galleries from Drupal 7 **Media 7.x‑2.x** |

```bash
drush en media_gallery_migration -y
```

Most new sites do not need either one.

## Verify it worked

Log in as an administrator and visit **Content → Media galleries**
(`/admin/content/media-gallery`). You should see an empty gallery listing with an
**Add media gallery** button. Create one, add a couple of images, save, and click a
thumbnail — it should open in the PhotoSwipe lightbox. Next, see
[Configuration](../configuration/index.md) to place the gallery blocks.
