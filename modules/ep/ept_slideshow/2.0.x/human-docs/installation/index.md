# Installation

## Requirements

EPT Slideshow builds on a few other modules:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base supplying per-instance design
  options (spacing, background, container width).
- **Paragraphs** (`paragraphs`) — the paragraph mechanism.
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules, for
  choosing the slide images.

The slideshow is driven by the **FlexSlider** JavaScript library. There are no PHP
extension requirements to install by hand.

> **Install prerequisite — an image media type must exist.** This module's
> configuration references the `image` media type (`media.type.image`). The
> Standard install profile creates it, but a **minimal** profile does not — on a
> stripped-down site, enabling this module fails with an unmet configuration
> dependency (`ept_slideshow_item.field_ept_slideshow_slide` referencing
> `media.type.image`) until the `image` media type exists. Create an **Image**
> media type first, or install on a Standard-based site.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_slideshow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, and the core media modules it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_slideshow -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together.** The EPT component modules do not each declare a
> version constraint on `ept_core`, and the shared widget base class has changed
> between releases. If you use several EPT modules, require and update them as a
> set so their versions stay in step with `ept_core`.

## Enable the module

```bash
drush en ept_slideshow -y
```

Enabling the module also enables `ept_core`, `paragraphs`, `media`, and
`media_library` if they aren't already on, then imports the **Slideshow**
paragraph type. (If the enable fails, check the image-media-type prerequisite
above.)

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm a **Slideshow** type is
   listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add a
   **Slideshow** paragraph, pick a few media images, and save.
3. View the page — the slideshow should render and cycle through the slides.

For how to place and style the slideshow, see
[How to use it](../index.md#how-to-use-it) in the overview.
