# Installation

## Requirements

Inline Styled Images needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Editor** (`editor`), **Image** (`image`) and **CKEditor 5**
  (`ckeditor5`) modules for the *Display image styles* filter.
- Core's **Responsive Image** module (`responsive_image`) as well, if you want the
  *Display responsive images* filter.

Drupal enables the declared dependencies (Editor, Image, Responsive Image) when you
turn the module on. There are no third-party Composer or PHP library requirements —
the CKEditor 5 JavaScript is prebuilt and shipped with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_responsive_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (Note the project machine name is
`inline_responsive_images`, even though the module's display name is "Inline Styled
Images".)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_responsive_images -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_responsive_images -y
```

Before the filters are useful, make sure you have some **image styles** (at
`/admin/config/media/image-styles`) and, for the responsive filter, some
**responsive image styles** (at `/admin/config/media/responsive-image-style`)
defined — these are the choices the filter offers editors.

There is no module settings page; all configuration happens on a text format. See
[How to use it](../index.md#how-to-use-it) in the overview.
