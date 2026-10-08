# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Text** (`text`) and **Editor** (`editor`) modules — both part of Drupal
  core and enabled as needed.

There are no third‑party PHP libraries to install. The optional
[File Hash](https://www.drupal.org/project/filehash) module improves duplicate
detection when the module reuses existing files, but it is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_image_saver -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_image_saver -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_image_saver -y
```

## Verify it worked

Go to **Configuration → Content authoring → Inline Image Saver**
(`/admin/config/content/inline-image-saver/settings`). If the settings form loads,
the module is installed. Out of the box, validation, downloading, and revision
creation are already **on** (replacement is off), so head to
[Configuration](../configuration/index.md) to choose which text formats to process
and tune the behavior to your workflow. Then edit a piece of content with an
external image, save it, and confirm the image has been downloaded into a local
file.
