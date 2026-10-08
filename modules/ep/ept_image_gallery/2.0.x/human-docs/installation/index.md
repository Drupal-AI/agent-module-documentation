# Installation

## Requirements

EPT Image Gallery builds on the Extra Paragraph Types framework and a few contrib
modules. It needs:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`drupal/ept_core ^2.0`) — the shared foundation for all EPT paragraph
  types (colors, breakpoints, shared settings).
- **GLightbox** (`drupal/glightbox ^1.0`) — provides the lightbox popup.
- **Paragraphs** (`drupal/paragraphs ^1.0`) — the paragraph system itself.
- Core's **Media** module — for the image reference field.

Composer pulls all of these in for you when you require the module. There are no extra PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_image_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the shared
dependencies (EPT Core, GLightbox, Paragraphs) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_image_gallery -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_image_gallery -y
```

Drupal enables the dependencies (EPT Core, GLightbox, Paragraphs, Media) at the same time.
Enabling the module creates the **EPT Image Gallery** paragraph type, its fields, the
`ept_gallery_image` (365×265) thumbnail image style, and the media display that routes
gallery images through GLightbox — so it is ready to use immediately. See the
[overview](../index.md#how-to-use-it) for adding your first gallery.

There are no submodules.
