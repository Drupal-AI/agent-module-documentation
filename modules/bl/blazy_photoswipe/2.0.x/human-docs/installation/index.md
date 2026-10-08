# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- The **Blazy** module (`drupal/blazy` ^3.0) enabled — this is a hard dependency
  and Composer pulls it in.
- The **PhotoSwipe JavaScript library** placed under `/libraries/photoswipe` (see
  below). This is *not* a Composer package — you download it separately.
- *(Optional, PhotoSwipe 4 only)* the `drupal/photoswipe` contrib module, which
  provides library plumbing and a settings source. Not needed for PhotoSwipe 5.

## Install with Composer

From the project root:

```bash
composer require drupal/blazy_photoswipe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `drupal/blazy` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/blazy_photoswipe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the PhotoSwipe library

The module integrates PhotoSwipe but does not bundle it. Download the PhotoSwipe
library and place it so the built files live under `/libraries/photoswipe/dist/…`
(that is, `web/libraries/photoswipe/dist/…` on a typical Composer/DDEV layout).
Without the library the lightbox option is selectable but will not initialise.

## Enable the module

```bash
drush en blazy_photoswipe -y
```

This enables Blazy PhotoSwipe (and Blazy, if it wasn't already on). Clear caches
afterwards so the new lightbox option is picked up:

```bash
drush cr
```

## Next step

The module has no settings page. To use it, choose **Image to PhotoSwipe** as the
Media switch on a Blazy-formatted field, and optionally switch to PhotoSwipe 5 from
Blazy's settings — see [How to use it](../index.md#how-to-use-it) on the overview
page.
