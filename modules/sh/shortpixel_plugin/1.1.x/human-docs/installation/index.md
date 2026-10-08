# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **ImageAPI Optimize** module (`imageapi_optimize`) — this processor plugs into
  it, so it is a required dependency.
- A **ShortPixel API key**. You can get one free at
  [shortpixel.com](https://shortpixel.com); the free account includes 100 image
  optimizations per month. Keep the key as a secret (store it in an environment
  variable rather than committing it).

There are no third-party PHP library requirements declared for the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/shortpixel_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in ImageAPI Optimize if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shortpixel_plugin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shortpixel_plugin -y
```

Drupal enables ImageAPI Optimize automatically as a dependency.

## Next step

The processor has no settings page of its own — you configure it from within an
ImageAPI Optimize pipeline. See the [overview](../index.md) for how to add the
ShortPixel processor, enter your API key, and choose a compression or CDN mode.
