# Installation

## Requirements

- **Drupal `^10.5 || ~11.2.0 || ~11.3.0 || ~11.4.0`** (`core_version_requirement`).
- These core modules, all enabled (Drupal will pull them in as dependencies):
  - **CKEditor 5** (`ckeditor5`)
  - **Image** (`image`)
  - **Media Library** (`media_library`)
- No third‑party Composer or PHP library requirements.

You will also need at least one **text format** that uses CKEditor 5 and has media
embedding, since that is where you turn the feature on.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_media_resize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_media_resize -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_media_resize -y
```

Enabling the module also installs its four image styles
(`cke_media_resize_small`, `_medium`, `_large`, `_xl`) and matching media view
modes.

## Verify it worked

Enabling the module alone does not turn on resizing anywhere — you must configure a
text format first. Follow "How to set it up on a text format" in the
[overview](../index.md), then open a content form that uses that text format, embed
an image from the media library, and confirm you can drag its corner handles to
resize it. After saving, view the page and confirm the image renders at the width
you chose.
