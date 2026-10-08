# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Layout Builder** (enabled to have sections to style), plus core
  **Image** (`image`), **Media** (`media`), and **Media Library** (`media_library`).
- The contrib **Layout Builder Styles** (`layout_builder_styles`) module — its
  vocabulary of classes supplies the style options.
- The contrib **Media Library Form Element** (`media_library_form_element`,
  **version 2.0 or newer**) module — used to pick the background image from the
  media library.

## Install with Composer

From the project root — this pulls in Layout Builder Styles and Media Library Form
Element alongside the module:

```bash
composer require drupal/layout_builder_backgrounds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_backgrounds -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_backgrounds -y
```

Drupal will enable the core media/image modules, Layout Builder Styles, and Media
Library Form Element as dependencies. Make sure **Layout Builder** itself is
enabled so you have sections to apply backgrounds to.

## Verify it worked

Edit a Layout Builder layout, add or configure a section, and confirm you can now
set a **background colour** and choose a **background image** from the media
library in the section's settings. See the overview's "How to use it".
