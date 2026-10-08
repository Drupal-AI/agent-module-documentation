# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) and **Paragraphs** (`paragraphs`) — the shared EPT base
  and field system.
- Core **Link** (`link`), **Media** (`media`), and **Media Library**
  (`media_library`) — slides come from the media library, with an optional link
  each.
- The **Tiny Slider** JavaScript library, which the carousel is built on.

> **Prerequisite worth knowing:** like the rest of the family, this module's install
> expects the **`media.type.image`** configuration to exist. On a minimal install
> profile with no image media type, enabling the module fails with an unmet
> configuration dependency until you create an image media type first.

Composer resolves the module's Drupal dependencies for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_carousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the EPT base, Paragraphs, and the Media
modules alongside this module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_carousel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure an image media type exists first (see the prerequisite above), then:

```bash
drush en ept_carousel -y
```

Drupal will enable `ept_core`, Paragraphs, Link, Media, and Media Library too if
they aren't already on.

## Verify it worked

Edit content that has a Paragraphs field allowing the Carousel type (or add such a
field first). Add a **Carousel** paragraph, pick a few slide images from the media
library, and save — the slides should render as a Tiny Slider carousel. If enabling
failed, check that an image media type (`media.type.image`) exists.
