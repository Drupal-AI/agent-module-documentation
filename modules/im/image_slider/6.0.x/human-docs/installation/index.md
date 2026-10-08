# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Options** (`options`) and **User** (`user`) modules, which Drupal
  enables automatically as dependencies.

There are no third-party Composer or PHP library requirements — the jssor
JavaScript library is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/image_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/image_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_slider -y
```

Enabling the module also installs two image styles
(`image_slider_gallery` and `image_slider_vertical_thumb_gallery`) used for
consistent thumbnail sizing.

## Next step

There is no separate settings page. Create your first slider and place its block
as described in the [overview](../index.md#how-to-use-it).
