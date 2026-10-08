# Installation

## Requirements

EPT Video and Image Gallery builds on several other modules:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base supplying per-instance design
  options (spacing, background, container width).
- **Paragraphs** (`paragraphs`) — the paragraph mechanism.
- Core's **Media** (`media`) module, for the gallery items.
- **GLightbox** (`glightbox`) and **GLightbox Media Video**
  (`glightbox_media_video`) — provide the lightbox and video handling.

There are no PHP extension requirements to install by hand.

> **Install prerequisite — the referenced media types must exist.** Like the rest
> of the EPT family, this module's configuration references media types that the
> Standard install profile creates but a **minimal** profile does not — create
> them first, or install on a Standard-based site.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_video_and_image_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, `glightbox`, `glightbox_media_video`, and the core media module it
needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_video_and_image_gallery -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together — this module especially.** It does not declare a
> version constraint on `ept_core`, and release 2.0.0 is incompatible with
> `ept_core` 2.0.0's widget base class (see the overview). Require and update the
> EPT modules as a set, and confirm the resolved `ept_core` version before
> enabling.

## Enable the module

```bash
drush en ept_video_and_image_gallery -y
```

Enabling the module also enables `ept_core`, `paragraphs`, `media`, `glightbox`,
and `glightbox_media_video` if they aren't already on, then imports the gallery
paragraph type.

> **Test the enable on a non-production environment first.** This release has been
> observed to fatal with an `ArgumentCountError` mid-install against `ept_core`
> 2.0.0, leaving other modules half-installed. If the enable fails, check and pin
> your `ept_core` version before retrying, and confirm the site is otherwise
> healthy.

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm the gallery type is listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add the
   gallery paragraph, add a few images and a video, and confirm the edit form
   works and saves.
3. View the page and click an item — it should open in the GLightbox lightbox.

For how to place and style the gallery, see
[How to use it](../index.md#how-to-use-it) in the overview.
