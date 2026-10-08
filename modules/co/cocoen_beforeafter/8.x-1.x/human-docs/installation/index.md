# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** (`image`) module — the only Drupal dependency.
- The **Cocoen** JavaScript library (version **2.x**), installed into your site's
  `/libraries` directory. This branch (`8.x-1.x`) supports Cocoen 2.x; Cocoen 3.x
  is not supported.

## Install with Composer

From the project root:

```bash
composer require drupal/cocoen_beforeafter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cocoen_beforeafter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Add the Cocoen library

The module needs the Cocoen JavaScript library present on disk. Download it and
extract it into your site's `libraries` directory so the file ends up at:

```
/libraries/cocoen/dist/js/cocoen.min.js
```

Getting this path right matters — the formatter loads the script from exactly
this location. Use the Cocoen **2.x** release.

## Enable the module

```bash
drush en cocoen_beforeafter -y
```

## Verify it worked

Go to the **Manage display** of an image or media-image field and open its
format dropdown — the **Cocoen beforeAfter** formatter should be listed. Set a
field with two images to that formatter and view the entity: the images should
render as a single draggable before/after slider. If the slider does not move,
double-check the library path above.
