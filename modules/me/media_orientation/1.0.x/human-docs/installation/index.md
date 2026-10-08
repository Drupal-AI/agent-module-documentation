# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module, with at least one **image** media type.
- The **Views Filter Select** (`views_filter_select`) module, which this module
  depends on — it turns the orientation into an exposed select filter in Views.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_orientation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including Views Filter Select — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_orientation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_orientation -y
```

Drupal will enable the Views Filter Select dependency at the same time.

## Verify it worked

Follow the steps in the [overview](../index.md): add the orientation list field to
your image media type and select it as the Media orientation field. Save a media
item and confirm the orientation value is populated (Landscape / Portrait /
Square). To backfill existing media, run `drush mo:resave image` (substituting your
bundle's machine name), then confirm those items now carry an orientation too.
