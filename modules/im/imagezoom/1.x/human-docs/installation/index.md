# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- At least one image field, and image styles suitable for the displayed and
  zoomed views (a larger style for the zoom).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/imagezoom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagezoom -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagezoom -y
```

## Submodules

- **Image Zoom Gallery** (`imagezoom_gallery`) — extends the hover-zoom effect to
  a gallery of images. Enable it only if you need gallery support:

  ```bash
  drush en imagezoom_gallery -y
  ```

## Verify it worked

Go to a content type's **Manage display** (for example **Structure → Content
types → Article → Manage display**) and confirm that **Image Zoom** now appears as
a format option for image fields. Set it on a field, pick your image styles, and
view the content — hovering over the image should reveal the magnified view. See
"How to use it" in the [overview](../index.md).
