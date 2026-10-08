# Install the OwlCarousel2 library (Drush)

The carousel needs the third-party **owlcarousel2** JS library, which the module does **not**
bundle. It must live at `/libraries/owlcarousel2/dist/owl.carousel.js` (plus
`dist/assets/owl.carousel.css` and `owl.theme.default.css`, referenced by the `owlcarousel`
asset library in `owlcarousel.libraries.yml`).

## Status check

`owlcarousel_requirements()` (runtime) reports **owlcarousel2 library: Installed / Not installed**
on *Reports → Status report*, erroring with a download link when the file is missing.

## Drush commands

Modern (Symfony console command, `src/Commands/OwlCarouselCommands.php`):

```bash
drush owlcarousel:download   # alias: oc:dl
```

Downloads OwlCarousel2 2.3.4 from GitHub, extracts it, and moves it to
`DRUPAL_ROOT/libraries/owlcarousel2`.

Legacy (drush 8 `owlcarousel.drush.inc`), still present:

```bash
drush owlcarousel-plugin [path]   # alias: owlcarouselplugin
```

## Manual install (equivalent)

1. Download the OwlCarousel2 2.3.4 release from
   `https://github.com/OwlCarousel2/OwlCarousel2`.
2. Rename the folder to `owlcarousel2`.
3. Place it under `/libraries` so `/libraries/owlcarousel2/dist/owl.carousel.js` exists.

Or via Composer with the package repository declared in the module's `composer.json`
(`composer require owlcarousel2/owlcarousel2`).
