# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base for the Extra Block Types family.
- **GLightbox** (`glightbox`) — provides the lightbox popup viewer.
- Core **Media** (`media`) module.

Composer resolves these automatically when you install with the `-W` flag below.
There are no third‑party PHP library requirements.

**Before you enable it:** the block's fields reference an **image media type**. If
your site has no `image` media type yet, create it first, or enabling can fail on an
unmet configuration dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_image_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_image_gallery -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_image_gallery -y
```

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder) — you should
see the **Image Gallery** block type. Add one, add a few images, and confirm the
thumbnails open in the GLightbox viewer on the rendered page.
