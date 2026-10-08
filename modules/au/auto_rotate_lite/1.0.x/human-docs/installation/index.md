# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **GD** image toolkit (Drupal's default) and PHP's **`exif`** extension —
  the effect uses `exif_read_data()` to read a photo's orientation tag. If EXIF
  is unavailable, images are left unchanged rather than erroring.
- No contrib module dependencies and no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_rotate_lite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_rotate_lite -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_rotate_lite -y
```

Once enabled, add the **Auto Rotate Lite** effect to an image style as described
on the [overview page](../index.md). There is no separate configuration screen.
