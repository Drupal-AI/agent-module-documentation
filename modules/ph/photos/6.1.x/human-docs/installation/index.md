# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Several core modules, which Drupal enables as dependencies: **Field UI**
  (`field_ui`), **Image** (`image`), **Media** (`media`), **Node** (`node`), and
  **Views** (`views`).

There are no required third-party Composer libraries, but a number of contrib modules
are **suggested** to unlock extra features — install whichever you want:

- **Crop API** (`drupal/crop`) and **Image Widget Crop** (`drupal/image_widget_crop`)
  — for cropping images.
- **Image Effects** (`drupal/image_effects`) — extra image effects.
- **Colorbox** (`drupal/colorbox`) — lightbox display of photos.
- **Plupload** (`drupal/plupload`) — the multi-image uploader (needed if you turn on
  Plupload upload in the settings).
- **EXIF Orientation** (`drupal/exif_orientation`) — auto-fix image orientation on
  upload.

## Install with Composer

From the project root:

```bash
composer require drupal/photos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add any of the suggested modules the same way, for example:

```bash
composer require drupal/plupload drupal/colorbox -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/photos -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en photos -y
```

Drupal enables the core dependencies (Field UI, Image, Media, Node, Views) for you.
Enabling Photos installs the **Photo album** content type, the `photos_image` entity,
and the module's supporting database tables.

## Submodule: Photos access

Photos ships one submodule, **Photos access** (`photos_access`), which adds per-album
privacy — leave an album open, lock it, restrict it to a list of users, or protect it
with a password. Enable it only if you need that:

```bash
drush en photos_access -y
```

It requires the base Photos module, which is already present once you have installed
the above.

## Next steps

Review the [Configuration](../configuration/index.md) page to set your image sizes,
display options, and upload preferences, and to grant the photo permissions to the
right roles. Then create your first **Photo album** node and start uploading.
