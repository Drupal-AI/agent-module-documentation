# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The contrib **CKEditor** (CKEditor 4) editor module (`ckeditor`). Because
  CKEditor 4 was removed from Drupal core in Drupal 10, this only applies to
  sites still running the contrib CKEditor 4 editor.
- The upstream **CKEditor `panelbutton` add-on library**, version **4.5.6 or
  later**, downloaded into your site (see below).

## Download the CKEditor library

This module wraps an upstream CKEditor add-on that is not bundled with it:

1. Download the `panelbutton` plugin (at least version 4.5.6) from the CKEditor
   add-on repository (historically `http://ckeditor.com/addon/panelbutton`).
2. Unpack it so the plugin lives in your site's root **`/libraries`** folder — for
   example `/libraries/panelbutton/plugin.js`.

## Install with Composer

From the project root:

```bash
composer require drupal/panelbutton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/panelbutton -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en panelbutton -y
```

## Verify it worked

Panel Button has no visible UI of its own, so verify it indirectly: enable a
plugin that depends on it (such as **Color Button**), add that plugin's button to
a CKEditor 4 text format's toolbar, and confirm its dropdown/panel opens in the
editor. If the panel appears, Panel Button and its library are working.
