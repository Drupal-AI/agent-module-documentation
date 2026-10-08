# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** and **File** modules enabled.
- An **`image` media type** configured, with an image field named
  **`field_media_image`** — the module attaches the files it finds to this field,
  so the standard core "Image" media type works out of the box.

The module creates its own tracking table (`media_from_images`) automatically when
you enable it. There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_from_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_from_images -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_from_images -y
```

Enabling the module creates the custom `media_from_images` tracking table used for
hash‑based deduplication.

## Verify it worked

Grant yourself the **administer media from images** permission, then visit
**Configuration → Media → Media From Images**
(`/admin/config/media/media-from-images`). You should see statistics comparing the
number of image files on the site with the number of media entities, plus buttons
to start the batch operations. From here you can run a batch — or run
`drush mfi:process` from the command line — to create the missing media.
