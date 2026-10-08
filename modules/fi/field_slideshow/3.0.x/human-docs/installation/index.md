# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **jQuery Cycle2** JavaScript library, installed into your site's
  `libraries/` directory (see below). This is **not** a Composer package and is
  **not** bundled with the module.
- Optional: the **Colorbox** module, if you want each slide to open in a Colorbox
  lightbox gallery.

## Install with Composer

From the project root:

```bash
composer require drupal/field_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_slideshow -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the Cycle2 library

The module expects Cycle2 at `/libraries/jquery.cycle2/jquery.cycle2.min.js`.
Download it from the Cycle2 project and place it there, for example:

```bash
mkdir -p web/libraries/jquery.cycle2
# copy jquery.cycle2.min.js into web/libraries/jquery.cycle2/
```

If you enable the **swipe** option in the formatter, also add the Cycle2 swipe
plugin at `/libraries/jquery.cycle2/jquery.cycle2.swipe.min.js`.

Until the library is present the slideshow simply won't animate — the images will
still render.

## Enable the module

```bash
drush en field_slideshow -y
```

Then go to **Manage display** for your content type, set an Image field's format
to **Slideshow**, and configure it — see
[How to use it](../index.md#how-to-use-it). There is no separate configuration
page.
