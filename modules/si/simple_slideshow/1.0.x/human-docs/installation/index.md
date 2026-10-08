# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Image** module (`image`) — enabled by default in a standard install.
- The **Splide** JavaScript library, placed in your site's `libraries` directory
  (see below). This is a required step — without the library the slideshow won't
  animate.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_slideshow`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_slideshow -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the Splide library

The module expects the Splide library on disk under `/libraries/splide/`.
Download Splide JS and extract it so the files land at:

- `/libraries/splide/dist/css/…`
- `/libraries/splide/dist/js/splide.min.js`

(the module's library definition references `/libraries/splide/dist/js/splide.min.js`
and the Splide "skyblue" theme CSS). If these paths aren't present, the field will
render but the carousel behaviour won't work.

## Enable the module

```bash
drush en simple_slideshow -y
```

## Verify it worked

Edit the **Manage display** of any entity with a multi-value image field, and check
that **Simple Slideshow** appears in the format dropdown. Choose it, save, and view
the entity — the images should slide as a carousel. See the **How to use it**
section of the [main guide](../index.md) for a full block-based walkthrough.
