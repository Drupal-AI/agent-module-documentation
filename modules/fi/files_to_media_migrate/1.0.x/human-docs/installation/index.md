# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media**, **Media Library**, **File**, **Migrate**, and **Migrate
  Drupal** modules. Media, File and Migrate are declared dependencies; enable
  Media Library and Migrate Drupal too, as the commands rely on them.
- **Drush**, since the module is driven entirely from the command line.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/files_to_media_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/files_to_media_migrate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and its dependencies

```bash
drush en media media_library file migrate migrate_drupal files_to_media_migrate -y
```

## Back up first

The commands transform existing content in place. **Take a database (and files)
backup** before running them.

## Run the migration commands

**1. Create the media reference fields** for a content type. Arguments are the
bundle, the field type, the target media bundle, and the entity type:

```bash
drush create-media-field article image image node
```

This creates a media reference field for each matching file field, suffixed with
`_media`.

**2. Migrate the file values into media.** Arguments are the field name, the field
type, and the entity type:

```bash
drush files-to-media field_featured_image image node
```

This moves the values of `field_featured_image` into `field_featured_image_media`.

## Finish in the UI

After migrating, enable the new `_media` fields on the bundle's **Manage form
display** and **Manage display** tabs so they appear on the edit form and when the
content is viewed.

## Verify it worked

Open a few migrated entities and confirm the new media fields are populated and
render correctly. Once you are satisfied, you can remove the redundant legacy file
fields.
