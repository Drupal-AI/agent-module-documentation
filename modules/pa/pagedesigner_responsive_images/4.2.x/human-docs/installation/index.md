# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md)** module
  (`pagedesigner`) and its **image submodule** (`pagedesigner_image`).
- The **ImageAPI Optimize WebP** module (`imageapi_optimize_webp`) — the WebP
  optimization pipeline this module builds on.

Composer resolves all of these as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/pagedesigner_responsive_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pagedesigner, the image
submodule, ImageAPI Optimize WebP and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagedesigner_responsive_images -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagedesigner_responsive_images -y
```

Drupal enables `pagedesigner_image` and the WebP pipeline as dependencies if they
aren't already on.

## Optional: focal‑point cropping

If you want editors to control how images are cropped, also enable the focal‑point
submodule:

```bash
drush en pagedesigner_focal_point -y
```

## Set the permission

This module provides its own permission for the Pagedesigner image feature. Visit
**People → Permissions** (`/admin/people/permissions`) and grant it to the appropriate
roles.

## Verify it worked

Place an image in Pagedesigner content and inspect the rendered page — the image should
be delivered as responsive markup (multiple sizes) and, where the WebP pipeline is
active, in WebP format.
