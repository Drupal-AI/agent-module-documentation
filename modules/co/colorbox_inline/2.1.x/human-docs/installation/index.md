# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Colorbox** module (`drupal/colorbox`) — this is a hard dependency, and
  Composer pulls it in for you.
- The **jQuery Colorbox** JavaScript library, which the parent Colorbox module
  needs. Colorbox provides a Drush command to download it
  (`drush colorbox:plugin`); see the Colorbox module's own documentation for
  details. Without that library the lightbox cannot open.

There are no additional PHP libraries required by Colorbox Inline itself.

## Install with Composer

From the project root:

```bash
composer require drupal/colorbox_inline -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in the required **Colorbox** module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colorbox_inline -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbox_inline -y
```

This enables Colorbox Inline and, if it isn't already on, the **Colorbox** module
too. You can also enable them from **Extend** (`/admin/modules`).

If you have not yet installed the jQuery Colorbox library for the parent module,
do that now (e.g. `drush colorbox:plugin`) so lightboxes actually appear.

## Next steps

There is nothing to configure. Add `data-colorbox-inline` attributes to your
trigger links — see [How to use it](../index.md#how-to-use-it) on the overview
page.
