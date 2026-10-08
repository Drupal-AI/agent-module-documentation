# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** (`image`) and **Field** (`field`) modules — part of Drupal core
  and enabled as needed.
- For the **Media Product Gallery** formatter, you'll be pointing at media
  entities, so core's Media module should be in use for that field.

There are no third-party Composer or PHP library requirements — the gallery/zoom
JavaScript ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/product_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/product_gallery -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en product_gallery -y
```

## Verify it worked

Go to a content type's **Manage display** and open the format dropdown for an
image or media reference field. You should see **Product Gallery** (and/or **Media
Product Gallery**) listed as an option. Choose it, configure the settings (see the
[overview page](../index.md)), save, and view a piece of content to confirm the
gallery renders with thumbnails, zoom, and the magnifier.
