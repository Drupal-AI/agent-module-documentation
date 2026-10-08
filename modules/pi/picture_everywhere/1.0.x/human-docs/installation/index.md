# Installation

## Requirements

Picture Everywhere needs:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0 or newer.**
- Core's **Image** module (`image`), which is part of a standard Drupal install.

Two optional integrations enhance it if present: the **SVG Image Field** module
(picked up automatically) and, for the optional WebP `<source>` feature, the
**[WebP](https://www.drupal.org/project/webp)** module. Neither is required.

## Install with Composer

From the project root:

```bash
composer require drupal/picture_everywhere -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/picture_everywhere -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en picture_everywhere -y
```

That's all it takes — the image‑template override is active immediately, with no
required configuration.

## Verify it worked

Load any page that renders an image (a node with an image field, for example) and
view the page source. Images that Drupal would previously have output as `<img>`
should now be wrapped in a `<picture>` element. If you also want the optional WebP
`<source>` behaviour, see the [overview](../index.md).
