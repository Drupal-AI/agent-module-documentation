# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **PM Carousel JavaScript library**, which must live at
  `web/libraries/pm-carousel`. Specifically, the module needs
  `/libraries/pm-carousel/dist/pm-carousel.umd.js` to be present. Installing with
  Composer (below) fetches this automatically from the maintainers' mirror fork.

## Install with Composer

From the project root:

```bash
composer require drupal/pm_carousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer also downloads the PM Carousel library files
into `web/libraries/pm-carousel`, so you do not have to install the JavaScript by
hand.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pm_carousel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pm_carousel -y
```

## Verify it worked

Confirm the library file exists at
`web/libraries/pm-carousel/dist/pm-carousel.umd.js`. Then enable one of the
companion modules — **PM Carousel Views** (to render a View as a carousel) or
**PM Carousel + Tobii Lightbox** (to open carousel images in a lightbox) — and
build a carousel to see it in action.
