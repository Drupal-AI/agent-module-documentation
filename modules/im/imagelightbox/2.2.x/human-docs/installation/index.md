# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Image** module (`image`) — a required dependency, enabled
  automatically.
- No third-party Composer or PHP library requirements. The imageLightbox.js
  JavaScript/CSS library is **bundled inside the module**, so there is nothing to
  download and no CDN involved.

For the **Media ImageLightbox** formatter you'll also want core's **Media**
module and a media reference field pointing at image media, but that is only
needed if you use that formatter.

## Install with Composer

From the project root:

```bash
composer require drupal/imagelightbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagelightbox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagelightbox -y
```

There's no configuration to do at install time. Head to any content type's
**Manage display** tab and choose an ImageLightbox formatter for an image or
media field — see the [overview](../index.md#how-to-use-it) for the per-display
options.
