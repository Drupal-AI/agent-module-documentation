# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- An image toolkit — the effect provides operations for both **GD** (Drupal's
  default) and **ImageMagick (imagick)**. Whichever your site uses under
  **Configuration → Media → Image toolkit** is supported.

There are no third-party Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_effect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_effect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_effect -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

Go to **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`), edit or add a style, and open the **Add a new
effect** dropdown. The **advance resize** effect provided by this module should now
be listed. See [Configuration](../configuration/index.md) for how to add and tune it.
