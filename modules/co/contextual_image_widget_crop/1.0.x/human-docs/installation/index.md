# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core's **Media Library** module (`media_library`).
- The contributed **Image Widget Crop** module
  (`image_widget_crop:image_widget_crop`), which in turn relies on the Crop API.

Both dependencies must be present. Composer installs Image Widget Crop for you
when you require this module with `-W`; enable Media Library from core as needed.

There are no third‑party PHP library requirements of this module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/contextual_image_widget_crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Image Widget Crop
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contextual_image_widget_crop -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contextual_image_widget_crop -y
```

Drupal will enable Media Library and Image Widget Crop as dependencies if they are
not already on.

## Verify it worked

Configure a fielded entity's image field to use an image style backed by a single
crop type, then add a Media image to that entity through the Media Library. In the
crop UI you should see only the crop type(s) relevant to that field's display,
rather than every crop type configured on the site.
