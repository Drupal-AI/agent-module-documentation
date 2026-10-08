# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **File** (`file`) and **Image** (`image`) modules — used to process
  thumbnails and full-screen images. These are part of core.
- **Drupal Commerce** with the **Product** module (`commerce_product`) enabled.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_gallery -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_gallery -y
```

## Verify it worked

Go to **Structure → Block Layout** (`/admin/structure/block`), click **Place
block** in any region, and search for **Commerce Gallery (Advanced Masonry)** — it
should appear in the list. Place and configure it as described in the
[main guide](../index.md#how-to-use-it), then view the page to confirm your
product images render as a gallery.
