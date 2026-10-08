# Installation

## Requirements

EPT Video builds on several other modules:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base supplying per-instance design
  options (spacing, background, container width).
- **Paragraphs** (`paragraphs`) — the paragraph mechanism.
- Core's **Media** (`media`) module, for the video media field.
- **GLightbox** (`glightbox`) and **GLightbox Media Video**
  (`glightbox_media_video`) — provide the lightbox overlay player.

There are no PHP extension requirements to install by hand.

> **Install prerequisite — the referenced media types must exist.** Like the rest
> of the EPT family, this module's configuration references media types that the
> Standard install profile creates but a **minimal** profile does not. On a
> stripped-down site the install can fail with an unmet configuration dependency
> until those media types (for example the `image` and video media types) exist —
> create them first, or install on a Standard-based site.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, `glightbox`, `glightbox_media_video`, and the core media module it
needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_video -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together.** The EPT component modules do not each declare a
> version constraint on `ept_core`, and the shared widget base class has changed
> between releases. If you use several EPT modules, require and update them as a
> set so their versions stay in step with `ept_core`.

## Enable the module

```bash
drush en ept_video -y
```

Enabling the module also enables `ept_core`, `paragraphs`, `media`, `glightbox`,
and `glightbox_media_video` if they aren't already on, then imports the **Video**
paragraph type. (If the enable fails, check the media-type prerequisite above.)

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm a **Video** type is listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add a
   **Video** paragraph, select a video from the media library, and save.
3. View the page and click the video — it should open in the GLightbox overlay.

For how to place and style the video, see
[How to use it](../index.md#how-to-use-it) in the overview.
