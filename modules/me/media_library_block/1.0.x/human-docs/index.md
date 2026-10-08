# Media Library Block — manual setup guide

**Media Library Block** (`media_library_block`) lets an editor pick a single media item from
Drupal's core Media Library and show it as a **block** — placed in any region, or dropped into
a Layout Builder section. It is the no‑code way to feature a specific image, video, document,
or remote video somewhere on the page without building a custom block type.

The module creates **one block per media type** on your site: if you have Image, Video,
Document and Remote video media types, you'll see a matching block for each in the *Media*
category of the block library. When you place one, its configuration form gives you a Media
Library picker (restricted to that media type) to choose exactly one item, plus a **View mode**
select so you decide how it renders — thumbnail, full, teaser, or any custom view mode you've
defined.

At render time the block respects access: it loads the chosen media, checks that the current
visitor may *view* it, and only then renders it. Placements also carry the right configuration
dependencies, so they export and import cleanly with your site config. There is **no central
settings page** — all configuration happens on each block placement. The module depends on
core **Media** and **Media Library** plus the contrib
[Media Library form element](https://www.drupal.org/project/media_library_form_element) module.

This guide is written for a **human** clicking through the admin UI. If you want the block
plugin, its config keys, access and dependency handling for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module (with its contrib dependency)
   and enable it.
2. [Configuration](configuration/index.md) — place a media block and set its media item and
   view mode, field by field.

## Where it lives in the admin menu

There is no dedicated settings page. You place and configure the blocks through the normal
block tools:

- **Block layout** — **Structure → Block layout** (`/admin/structure/block`), then *Place
  block* in a region and look for your media types under the **Media** category.
- **Layout Builder** — add a block in a section and pick the media type you want.
