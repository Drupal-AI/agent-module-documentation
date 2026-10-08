# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Media** module, with **Standalone media URL** enabled so media entities
  have their own viewable pages (this is where the previews appear).

There are no third‑party Composer or PHP library requirements, and no modules
outside core.

## Install with Composer

From the project root:

```bash
composer require drupal/imagestyles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagestyles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagestyles -y
```

## Enable standalone media URLs

The previews are shown on media entity pages, which only exist when **Standalone
media URL** is turned on:

1. Go to **Configuration → Media → Media settings**
   (`/admin/config/media/media-settings`).
2. Enable **Standalone media URL** and save.

## Verify it worked

Visit a media entity page, for example `/media/123`. You should see the image
rendered through each of your image styles. If media pages 404 instead, revisit
the Standalone media URL setting above.
