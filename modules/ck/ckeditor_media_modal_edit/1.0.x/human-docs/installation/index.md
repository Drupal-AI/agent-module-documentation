# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`).
- A text format that uses **CKEditor** with the media embed (`drupal-media`)
  filter enabled — that is what puts the media library widget into the editor,
  which is where this module adds its edit links.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_media_modal_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_media_modal_edit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_media_modal_edit -y
```

There is no configuration step — the edit links appear automatically wherever the
media library widget is used.

## Make sure your text format embeds media

If you have not already, edit the text format your editors use at **Configuration
→ Content authoring → Text formats and editors** and confirm it uses CKEditor with
the media embed filter, so the media library widget (and thus the new edit links)
appears.

## Verify it worked

Open a content field with a media‑enabled text format, launch the media library
widget, and confirm an **Edit this media** pencil link appears next to media items
you can update. Click it and check that the media edit form opens in a modal and
closes cleanly on save.
