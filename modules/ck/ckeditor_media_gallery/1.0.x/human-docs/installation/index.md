# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core modules only: **CKEditor 5** (`ckeditor5`), **Media** (`media`), **Media
  Library** (`media_library`), plus core **Filter** and **Editor**. Drupal enables
  the declared dependencies for you.
- **Optional but recommended:** core **Responsive Image** — enable it to get
  responsive image style options in the gallery settings.
- The **GLightbox** JavaScript library (MIT licensed, no commercial license
  needed) powers the fullscreen lightbox. By default it is loaded from the
  **jsDelivr CDN**; to serve it locally, override the `glightbox` library
  definition in a theme or custom module.

> **Egress note:** loading GLightbox from a CDN means visitors' browsers request
> a script from an external host. If your policies require self‑hosted assets,
> override the library to a local copy before going live.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_media_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_media_gallery -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_media_gallery -y
```

If you want responsive image style options, also enable core Responsive Image:

```bash
drush en responsive_image -y
```

## Verify it worked

The module does nothing visible until you add its button and filter to a text
format — see [Configuration](../configuration/index.md). After that, edit content
that uses the format, click the **Image gallery** button, pick a few images from
the Media Library, and confirm the gallery renders inside the editor.
