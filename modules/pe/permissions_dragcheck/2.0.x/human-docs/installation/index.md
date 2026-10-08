# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11**
  (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- The **Libraries** module.
- The **Drag Check** JavaScript library
  ([scarlac/drag-check-js](https://github.com/scarlac/drag-check-js)) — the
  module wraps this library, so it must be present for the drag behaviour to
  work.

## Install with Composer (recommended)

The Drag Check library is not on packagist.org, so first tell Composer where to
find it by adding a package repository to your project's `composer.json`, under
the `repositories` section:

```json
{
  "type": "package",
  "package": {
    "name": "scarlac/drag-check-js",
    "version": "2.0.2",
    "type": "drupal-library",
    "dist": {
      "url": "https://github.com/scarlac/drag-check-js/archive/v2.0.2.zip",
      "type": "zip"
    }
  }
}
```

Then require both the library and the module together:

```bash
composer require scarlac/drag-check-js drupal/permissions_dragcheck -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require … -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Manual installation (alternative)

If you are not using Composer, download and extract scarlac's Drag Check library
(master) into your site's `/libraries` folder, named `drag-check-js` — that
folder should then contain a `dist` subfolder (i.e. `/libraries/drag-check-js/dist`).
Then download and place the module as usual.

## Enable the module

```bash
drush en permissions_dragcheck -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`). Click a checkbox
and drag the mouse up or down across the checkboxes next to it — they should all
toggle together. If dragging does nothing, the Drag Check library is probably not
being found; confirm it is installed at `/libraries/drag-check-js/dist` (or via
the Composer package above) and clear caches with `drush cr`.
