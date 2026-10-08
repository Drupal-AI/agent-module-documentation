# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Crop API** module (`crop`) — Crop or Fill extends its crop effect and reuses
  its crop types.
- **ImageMagick module** — *optional*, only if you want to use the ImageMagick
  toolkit. Both GD (Drupal's default) and ImageMagick toolkits are supported.

There are no third-party PHP library requirements beyond the image toolkit you
already use.

## Install with Composer

From the project root:

```bash
composer require drupal/crop_or_fill -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Crop API and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crop_or_fill -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crop_or_fill -y
```

Drupal will enable the Crop API alongside it if it isn't already on.

## Verify it worked

Go to **Configuration → Media → Image styles**, edit or create an image style, and
open the **Add a new effect** dropdown. You should see **Crop or fill** among the
available effects. Adding it confirms the module is active — see
[Configuration](../configuration/index.md).
