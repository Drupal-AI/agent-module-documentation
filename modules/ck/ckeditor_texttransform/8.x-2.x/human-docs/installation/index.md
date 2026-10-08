# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The contrib **CKEditor** module (the CKEditor 4 editor). This module integrates
  CKEditor **4**, not core's CKEditor 5.
- The third-party **Text Transform** CKEditor 4 add-on, downloaded into your
  site's `libraries` directory (see step 2 below). This is required — the buttons
  do nothing without it.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_texttransform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_texttransform -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## 2. Download the CKEditor Text Transform plugin

The editor behaviour comes from a third-party CKEditor 4 add-on that is **not**
shipped with the module:

1. Download the **texttransform** plugin from
   <https://ckeditor.com/addon/texttransform>.
2. Unpack it into your site's root **`libraries`** folder so the plugin lives at
   `/libraries/texttransform/` (the add-on's `plugin.js` should be inside that
   directory).

## Enable the module

```bash
drush en ckeditor_texttransform -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
format that uses the CKEditor 4 editor, and confirm the Text Transform button(s)
are available to drag into the toolbar. Add one, save, then edit content: select
some text and click the button to confirm the case changes. If the buttons appear
but nothing happens, double-check the library path is exactly
`/libraries/texttransform/` and clear caches.
