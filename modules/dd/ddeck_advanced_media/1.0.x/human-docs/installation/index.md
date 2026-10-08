# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules, all of which Drupal will enable as dependencies: **Media**
  (`media`), **Media Library** (`media_library`), **CKEditor 5** (`ckeditor5`),
  and **Image** (`image`).
- The **Plyr** and **PhotoSwipe** front-end libraries, used for playback and the
  lightbox gallery. Install these through Composer as part of your site build.

There is no separate PHP library requirement declared by the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/ddeck_advanced_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ddeck_advanced_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ddeck_advanced_media -y
```

Drupal will enable the required Media, Media Library, CKEditor 5, and Image
modules automatically if they are not already on.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage display**. On a media
or image field, open the **Format** dropdown — you should now see the DDECK Plyr
formatters and **PhotoSwipe Media Gallery** listed alongside the core options.
Pick one, save, and view a piece of content to confirm the player or gallery
renders. See the main guide's [How to use it](../index.md#how-to-use-it) section
for the full field-display and CKEditor setup.
