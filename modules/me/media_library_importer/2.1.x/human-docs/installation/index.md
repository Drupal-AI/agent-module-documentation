# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 | ^11`).
- Core's **Media** and **Media Library** modules enabled.
- The **Queue UI** module (`drupal/queue_ui`, `^3.1`) — a required dependency that provides
  the batch runner the importer uses, and a UI for inspecting the pending import queue.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Queue UI and any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_importer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_importer -y
```

Drupal will enable Media, Media Library, and Queue UI automatically as dependencies if they
are not already on.

## Optional submodule — EXIF for images

If you import photographs and want to capture camera metadata (EXIF) into the created Media,
enable the bundled submodule:

```bash
drush en media_image_exif_importer -y
```

It adds EXIF extraction to core's Image media source. Leave it off if you do not need it.

## Grant the permissions

The importer defines two permissions — **Configure media library importer** and **Import
files into media library**. Neither is limited to the Media Library, so assign them only to
trusted administrator roles. See the [Configuration](../configuration/index.md) page for what
each one gates.
