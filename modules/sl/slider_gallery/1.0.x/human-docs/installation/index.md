# Installation

## Requirements

Image Slider Gallery is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal modules — it has no module dependencies.
- No third-party PHP or Composer libraries.

Keep in mind the module is **not covered by the security advisory policy**, so
apply your own judgement before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/slider_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slider_gallery -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slider_gallery -y
```

Once enabled, images you point at the module render as a sliding carousel
gallery instead of a static grid.
