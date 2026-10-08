# Installation

## Requirements

EPT Image builds on a few other modules:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core ^2.0`) — the shared base supplying per-instance design
  options (spacing, background, container width).
- **Paragraphs** (`paragraphs ^1.0`) — the paragraph mechanism.
- Core's **Image** (`image`) and **Media** (`media`) modules, for the media field
  that holds the image.

There are no PHP extension or third-party library requirements to install by
hand.

> **Install prerequisite — an image media type must exist.** This module's
> configuration references the `image` media type (`media.type.image`). The
> Standard install profile creates that media type, but a **minimal** profile does
> not — on a stripped-down site, enabling this module fails with an unmet
> configuration dependency until the `image` media type exists. If you are on a
> minimal site, create an **Image** media type first (or install on a
> Standard-based site).

## Install with Composer

From the project root:

```bash
composer require drupal/ept_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, and the core modules it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together.** The EPT component modules do not each declare a
> version constraint on `ept_core`, and the shared widget base class has changed
> between releases. If you use several EPT modules, require and update them as a
> set so their versions stay in step with `ept_core`.

## Enable the module

```bash
drush en ept_image -y
```

Enabling the module also enables `ept_core`, `paragraphs`, `image`, and `media`
if they aren't already on, then imports the **Image** paragraph type. (If the
enable fails, check the image-media-type prerequisite above.)

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm an **Image** type is listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add an
   **Image** paragraph, select a media image, and save.
3. View the page — the image should render at the paragraph's position.

For how to place and style the image, see
[How to use it](../index.md#how-to-use-it) in the overview.
