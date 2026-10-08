# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Media Contextual Cropping API** (`media_contextual_crop`), the 2.0.x line.
- **Image Widget Crop** (`image_widget_crop`) — the crop plugin this adapter
  bridges to.
- To do any actual cropping you also need a **family module** — Media Contextual
  Crop Embed (`media_contextual_crop_embed`) or Media Contextual Crop Reference
  (`media_contextual_crop_field_formatter`).

## Install with Composer

From the project root:

```bash
composer require drupal/media_contextual_crop_iwc_adapter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the base API
module and Image Widget Crop and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_contextual_crop_iwc_adapter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_contextual_crop image_widget_crop media_contextual_crop_iwc_adapter -y
```

Then enable a family module for the place you want to crop, for example the embed
integration:

```bash
drush en media_contextual_crop_embed -y
```

## Verify it worked

Confirm the adapter is enabled
(`drush pm:list --status=enabled | grep iwc_adapter`). With the API, Image Widget
Crop, a family module, and this adapter all enabled, set up contextual cropping on
a field or in CKEditor 5 and check that the Image Widget Crop interface appears.
