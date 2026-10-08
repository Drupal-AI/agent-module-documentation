# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- The **Magnific Popup JavaScript/CSS library**, placed under
  `web/libraries/magnific-popup` (see below). This is not a Composer package.
- Optional: **Video Embed Field** (`drupal/video_embed_field`), which unlocks a
  second *Magnific Popup* formatter for video fields.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/magnific_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/magnific_popup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the Magnific Popup library

The module ships only the glue code — you must download the third-party Magnific
Popup library separately and place it so that the vendor files resolve at:

```
web/libraries/magnific-popup/dist/jquery.magnific-popup.min.js
web/libraries/magnific-popup/dist/magnific-popup.css
```

If you have an older download that puts the files at the flat path
`web/libraries/magnific-popup/jquery.magnific-popup.min.js`, the module detects
and rewrites that legacy layout automatically — you do not need to configure which
layout you have. Either way, without the library present the popup will not
initialize in the browser (though the formatter still renders the thumbnails).

## Enable the module

```bash
drush en magnific_popup -y
```

There are no submodules.

## Verify it worked

Pick the **Magnific Popup** formatter on an image field's *Manage display* (see
the [main guide](../index.md#how-to-use-it)), then load a page showing that field
and click a thumbnail — the image should open in a lightbox. If nothing happens,
the usual cause is the missing vendor library under `web/libraries/magnific-popup`.
