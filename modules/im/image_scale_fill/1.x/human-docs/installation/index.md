# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **GD** image toolkit that ships with Drupal's PHP. This module currently
  supports GD only; there is no ImageMagick path.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_scale_fill -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_scale_fill -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_scale_fill -y
```

## Verify it worked

Go to **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`), edit or add a style, and open the
**Effect** select list. You should see the **Scale and Fill** effect available to
add. See the [manual setup guide](../index.md) for how to configure it.
