# Installation

## Requirements

- **Drupal 8.9, 9, or 10** (`core_version_requirement: ^8.9 || ^9 || ^10`).
- Core's **Image** (`image`) module.
- The **External Media** (`external_media`) contrib module.
- The **Image Widget Crop** (`image_widget_crop`) contrib module.

Both External Media and Image Widget Crop must be enabled for this bridge module
to install — it does nothing without them.

## Install with Composer

From the project root:

```bash
composer require drupal/external_media_crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
required External Media and Image Widget Crop modules along with any shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_media_crop -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_media_crop -y
```

Enabling this module will also require External Media and Image Widget Crop to be
on; enable them first (or let Drush resolve them) if they aren't already.

## Verify it worked

Go to any content type's **Manage form display** (Structure → Content types →
*(bundle)* → Manage form display) and open the widget dropdown for an image
field. You should see **External Media with Image Widget Crop** listed as an
option. Selecting it is the whole setup — see
[Configuration](../configuration/index.md) for the widget's crop-type options.
