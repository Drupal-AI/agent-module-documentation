# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The external **Slimbox2 jQuery library** — this must be present for the
  lightbox to work.
- On older branches, the **Libraries API** module is used to manage the library.
  (The Drupal 8+ branch under development does not require Libraries API.)

## Install with Composer

From the project root:

```bash
composer require drupal/slimbox2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slimbox2 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

The module's README recommends managing the Slimbox 2.05 library itself with
Composer on Drupal 8/9/10 — follow the README if you are upgrading from an older
release, since the newer library uses an autoload script.

## Add the Slimbox2 library

You need the Slimbox2 jQuery plugin in place. Two common ways:

- **Drush (recommended on older branches).** Enable Libraries API
  (`drush en libraries -y`), enable this module (`drush en slimbox2 -y`), then
  fetch the plugin with `drush slimbox2-plugin`, which downloads it into your
  libraries folder.
- **Manual.** Download the Slimbox 2 plugin (release 2.05), rename the folder to
  `slimbox2`, and place it in your site's libraries folder so the path resolves
  at `libraries/slimbox2` (or `/sites/all/libraries/slimbox2` on older sites).

## Enable the module

```bash
drush en slimbox2 -y
```

## Verify it worked

Add `rel="lightbox"` to a link that points at an image, then click it on the
front end. The image should open in a Slimbox overlay rather than loading as a
bare image page. If it navigates away instead, the Slimbox2 library is probably
not being found — recheck the library path above.
