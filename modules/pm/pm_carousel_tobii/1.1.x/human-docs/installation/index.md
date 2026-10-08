# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **PM Carousel Accessible Slider** module (`pm_carousel`) and the **Lightbox
  Tobii Image Formatter** module (`lightbox_tobii`) — both enabled.
- Two external JavaScript libraries on disk:
  - **PM Carousel** at `web/libraries/pm-carousel` (needs
    `/libraries/pm-carousel/dist/pm-carousel.umd.js`).
  - **Tobii** at `web/libraries/tobii` (needs `/libraries/tobii/dist/tobii.umd.js`
    and `/libraries/tobii/dist/tobii.min.css`).

  Both libraries are fetched automatically from the maintainers' mirror fork when
  you install with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/pm_carousel_tobii -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the `pm_carousel` and
`lightbox_tobii` module dependencies and downloads the PM Carousel and Tobii
library files into `web/libraries/`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pm_carousel_tobii -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pm_carousel_tobii -y
```

Drupal enables the `pm_carousel` and `lightbox_tobii` dependencies for you.

## Verify it worked

Confirm both library files exist —
`web/libraries/pm-carousel/dist/pm-carousel.umd.js` and
`web/libraries/tobii/dist/tobii.umd.js`. Then display a PM Carousel of images and
click one: it should open in the Tobii lightbox.
