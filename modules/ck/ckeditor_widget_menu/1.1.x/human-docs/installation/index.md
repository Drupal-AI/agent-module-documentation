# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A CKEditor editor: core's **CKEditor 5**, or the contrib **CKEditor 4** module.
- The third-party **ckeditor-widgetmenu** JavaScript library, placed in your
  site's `libraries` directory (see step 2). The dropdown does not work without it.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_widget_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_widget_menu -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## 2. Download the JavaScript library

The dropdown behaviour comes from a small npm package that is **not** bundled with
the module:

1. Get the **ckeditor-widgetmenu** package from
   <https://www.npmjs.com/package/ckeditor-widgetmenu>.
2. Place it in your site's root **`libraries`** directory, and make sure the
   directory is named **`widget_menu`**.
3. Confirm the plugin file is present at **`/libraries/widget_menu/plugin.js`** —
   if that exact path exists, the library is installed correctly.

## Enable the module

```bash
drush en ckeditor_widget_menu -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a format, and add the **widget_menu** button to the toolbar with some buttons
grouped next to it (see the module overview for CKEditor 4 vs 5 placement). Save,
then edit content and confirm the grouped buttons now appear inside a single
dropdown. If the button shows but the dropdown is empty or errors, recheck the
library path at `/libraries/widget_menu/plugin.js` and clear caches.
