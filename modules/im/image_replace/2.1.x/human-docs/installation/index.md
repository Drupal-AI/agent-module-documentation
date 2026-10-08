# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Image** module (`image`) — Drupal enables it as a dependency.
- **Optional:** the **ImageMagick** module (`drupal/imagemagick`) if you want to
  use the ImageMagick toolkit; Image Replace ships an ImageMagick replace
  operation as well as a GD one. The GD toolkit that ships with core works out of
  the box.

There are no other PHP library requirements, no permissions, and no Drush
commands.

## Install with Composer

From the project root:

```bash
composer require drupal/image_replace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/image_replace -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

If you also want the ImageMagick option:

```bash
composer require drupal/imagemagick -W
drush en imagemagick -y
```

## Enable the module

```bash
drush en image_replace -y
```

## Next steps

There is no configuration page to visit. Head to the [overview](../index.md) and
follow **How to use it** — add the **Replace image** effect to a style, then map
a source field on your image field, and re-save your content.
