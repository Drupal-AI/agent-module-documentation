# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The contributed **Color Field** module (`color_field`) — this provides the field
  type that gets populated.
- Core **Image** (`image`), which provides the source image field. It is part of a
  standard install.

Composer/Drupal pull in Color Field as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/color_field_from_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including `color_field`, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color_field_from_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_field_from_image -y
```

This also enables Color Field if it is not already on.

## Verify it worked

On a bundle that has both an image field and a Color Field, open the Color Field's
settings — you should see the **"Color Field from image"** behavior option (see
"How to use it" on the [overview page](../index.md)). Save an entity with an image,
and the Color Field should be filled with the image's dominant color.
