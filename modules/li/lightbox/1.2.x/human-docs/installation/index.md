# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core **Image** (`image`) — this is the only dependency, and Drupal enables it
  automatically (it is on by default on a standard site).
- No third‑party PHP libraries are required.
- To actually render a clickable lightbox you'll also want a **formatter** module
  built on this base — **Lightbox Tobii Image Formatter** or **Lightbox Fancybox
  Image Formatter**.

## Install with Composer

From the project root:

```bash
composer require drupal/lightbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lightbox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lightbox -y
```

## Submodules

Enable the one that matches your images:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Lightbox Media** | `lightbox_media` | Lightbox support for images managed as core **Media**. |
| **Lightbox Responsive** | `lightbox_responsive` | Lightbox support for **responsive images**. |

For example:

```bash
drush en lightbox_media -y
```

You'll also enable a formatter module (Lightbox Tobii or Lightbox Fancybox) so
there's an actual lightbox formatter to choose on your image field.

## Verify it worked

1. Confirm **Lightbox** (and the submodule and formatter you enabled) is on under
   **Extend** (`/admin/modules`).
2. Go to a content type's **Manage display**, set an image field to the lightbox
   formatter, and save.
3. View a piece of that content and click the image — it should open in a lightbox
   overlay.

There is no configuration step beyond the field display — see the module's
[main page](../index.md).
