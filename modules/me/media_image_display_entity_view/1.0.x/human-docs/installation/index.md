# Installation

## Requirements

- **Drupal 11.4 or newer** (`core_version_requirement: ^11.4`).
- Core's **Media** module enabled (Drupal enables it automatically as a
  dependency).
- *(Only for the submodule)* The **Entity Embed** contributed module, if you want
  the CKEditor in‑text embed support.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_image_display_entity_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_image_display_entity_view -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_image_display_entity_view -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **CKEditor support** | `ckeditor_support` | Brings the same "choose the display mode" control to in‑text media embeds, working together with the *Entity Embed* module. Enable it only if you embed media inside CKEditor content. |

Enable it when you need it:

```bash
drush en ckeditor_support -y
```

## Verify it worked

Go to any bundle's **Manage display**, find a media reference field that points at
image media, and confirm you can now pick the **view mode** in the formatter's gear
settings. If you enabled the submodule, check that the *Entity Embed* dialog offers
the same display‑mode choice for embedded media.
