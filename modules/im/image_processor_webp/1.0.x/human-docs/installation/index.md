# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A working image processing toolkit that supports WebP. Drupal's default **GD**
  toolkit supports WebP on modern PHP builds; **ImageMagick** is another option. You
  choose which toolkit the module uses on its settings page.

There are no additional module dependencies declared, and no third‑party Composer or
PHP library requirements. Note this project is **not covered by Drupal's security
advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/image_processor_webp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_processor_webp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_processor_webp -y
```

## Verify it worked

Open the module's settings interface (see [Configuration](../configuration/index.md))
and confirm you can pick an image toolkit and enable automatic conversion. Then
upload a JPG or PNG and check that a WebP copy is produced and that image markup on
the page is rendered as `<picture>` with a WebP source.
