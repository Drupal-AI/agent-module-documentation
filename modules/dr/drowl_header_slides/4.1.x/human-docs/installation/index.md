# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Module dependencies (Composer and Drupal will pull these in):
  - **Slick** (`slick`) — the carousel/slideshow library integration.
  - Core **Views** (`views`), **Media** (`media`), and **Block content**
    (`block_content`).
  - **DROWL Media** (`drowl_media`) — supplies the "Slide" media configuration.
  - **Fences** (`fences`), **Menu Item Extras** (`menu_item_extras`), and
    **Views Linkarea** (`views_linkarea`).

Slick in turn relies on the Slick JavaScript library (and Blazy); install it the
way the Slick module documents. There are no additional PHP library requirements
from this module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_header_slides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Slick, DROWL
Media, and the other dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_header_slides -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_header_slides -y
```

Enabling it also enables its dependencies. The header‑slides block type and the
"Slide" media type become available immediately.

## Verify it worked

Go to **Content → Blocks** and confirm you can create a new header‑slides block,
then place it via **Structure → Block layout**. See "How to use it" in the
[overview](../index.md) for the full flow.
