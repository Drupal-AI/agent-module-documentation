# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core modules only: `block`, `user`, `node`, `image`, `options`, and `link` —
  Drupal enables these as dependencies automatically. There is no contrib
  dependency and no external library to download.
- **Bootstrap CSS/JS** at the theme level for the slider to animate — use a
  Bootstrap-based theme (Drupal Bootstrap, Barrio) or supply Bootstrap yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/diba_carousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/diba_carousel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en diba_carousel -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
**Diba carousel** block is available to place. Add it to a region, configure its
content and field mapping, and view a page in that region. If the slider shows but
does not animate, confirm your theme is providing Bootstrap's CSS and JavaScript
— see the "How to use it" section of the [overview](../index.md#how-to-use-it).
