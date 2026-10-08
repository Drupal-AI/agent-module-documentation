# Installation

## Requirements

SVG Image Widget Crop is a shim that sits between two other modules, so those are
its main requirements:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Image Widget Crop** (`image_widget_crop`) — the crop widget this module
  adjusts.
- **SVG Image** (`svg_image`) — provides SVG support; the shim checks for it when
  deciding to skip cropping.

There are no additional PHP libraries. Note that the module is *minimally
maintained* (maintenance fixes only), which is fine for a small compatibility
shim like this.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_image_widget_crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
`image_widget_crop` and `svg_image` dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_image_widget_crop -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_image_widget_crop -y
```

That is all there is to it. With Image Widget Crop and SVG Image also enabled, the
exclusion is automatic — there is no configuration. Upload an SVG to a
crop‑enabled image field and confirm the crop UI is skipped, while a PNG or JPG
still shows the crop step.
