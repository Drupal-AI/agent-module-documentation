# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`), running the
  **contributed CKEditor 4** editor (this module does not work with CKEditor 5).
- The **Panel Button** module (`panelbutton`), which provides the floating-panel UI
  the color picker uses — Composer pulls it in as a dependency.
- The upstream **CKEditor Color Button** JavaScript library (v4.5.6+), downloaded and
  placed manually (see below).

## Download the plugin library

The color-button JavaScript is a third-party CKEditor add-on and is **not** included
with the module:

1. Download the Color Button add-on (at least version 4.5.6) from the CKEditor add-on
   repository.
2. Place it in your site's libraries folder so the file lives at
   `/libraries/colorbutton/plugin.js`.

The module implements `hook_requirements()`, so if the library is missing you will
see a warning on the **Status report** (`/admin/reports/status`).

## Install with Composer

From the project root:

```bash
composer require drupal/colorbutton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including Panel Button, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colorbutton -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbutton -y
```

This also enables Panel Button if it is not already on.

## Verify it worked

Check the **Status report** (`/admin/reports/status`) to confirm the plugin library
is detected. Then edit a CKEditor 4 text format (**Configuration → Content authoring →
Text formats and editors**) — the **Text Color** and **Background Color** buttons
should be available to drag into the toolbar. See "How to use it" on the
[overview page](../index.md) for the rest.
