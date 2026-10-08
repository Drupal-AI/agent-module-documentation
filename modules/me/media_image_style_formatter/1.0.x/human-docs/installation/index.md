# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Media** module enabled (Drupal enables it automatically as a
  dependency).
- Image media bundles with an image field (the core default is
  `field_media_image`).
- *(Optional)* Image styles configured at **Configuration → Media → Image styles**
  — not needed if you only use the "original image" option.

There are no third‑party Composer or PHP library requirements, and no other modules
are required.

## Install with Composer

From the project root:

```bash
composer require drupal/media_image_style_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_image_style_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_image_style_formatter -y
```

After enabling, it's a good idea to **clear caches** so the new options appear on
the *Rendered entity* formatter.

## Verify it worked

Go to a bundle's **Manage display**, set a media (Image) reference field's format to
**Rendered entity**, and open its gear settings. You should see a new **Override
entity image style** option, with controls to pick the image field and an image
style (or "None (original image)"). If the options don't show, clear caches and
check the field really references Image media bundles.
