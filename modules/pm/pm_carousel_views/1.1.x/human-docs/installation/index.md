# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core **Views** (`views`) enabled.
- The **PM Carousel Accessible Slider** module (`pm_carousel`), which provides the
  carousel JavaScript library at `web/libraries/pm-carousel`. Install it too if you
  have not already.

## Install with Composer

From the project root:

```bash
composer require drupal/pm_carousel_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed. Make sure `drupal/pm_carousel` is also installed so the carousel
library is available.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pm_carousel_views -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pm_carousel_views -y
```

## Verify it worked

Edit a View at **Structure → Views** and open its **Format** settings. **PM
Carousel** should appear as an available display style. Select it, save, and view
the page — the results should render as a carousel.
