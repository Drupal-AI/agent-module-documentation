# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — a dependency Drupal enables automatically.
- The **lightGallery 2.x** JavaScript library. Aside from this library there are
  no other dependencies for the 2.x branch. **Note the licensing terms** for
  lightGallery 2.x described on the [overview](../index.md) — the library
  requires a license for most uses.

## Install with Composer

From the project root:

```bash
composer require drupal/lightgallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lightgallery -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

Consult the module's README for the exact place to put the lightGallery library
files if they are not fetched for you, since the 2.x library is licensed and
distributed separately.

## Enable the module

```bash
drush en lightgallery -y
```

## Verify it worked

On a multi‑value image or media field's **Manage display**, choose the
**lightGallery** formatter and save. Visit a page that shows that field and click
a thumbnail — it should open in the lightGallery lightbox with thumbnails and
navigation. If nothing happens, confirm the lightGallery library is installed and
loading.
