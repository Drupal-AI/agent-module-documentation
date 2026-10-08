# Media - Parent Entity Link — manual setup guide

**Media - Parent Entity Link** (`media_parent_entity_link`) adds a **"Link to
parent entity"** checkbox to the image formatters on media entities. Tick it, and
when a media item is rendered as part of some other content — say an image
referenced by an article — its image links to *that article's* page instead of to
the media item's own page or the raw file. It's the "click the thumbnail, go to the
item" behavior people expect from card grids, galleries, and teaser listings, with
no custom preprocess code or Twig overrides.

Media items are reusable, so the same image can be embedded by many different
pieces of content. This module handles that correctly: at render time it figures
out which entity is *currently* referencing the media and points the image link at
that specific parent, and it registers a cache context so the same media caches a
different link per parent. It works with normal field rendering and with Layout
Builder, and it applies per view mode — so you can link to the parent in the teaser
display but not the full display, for example.

The module has no settings page of its own, no permissions, and no dependencies
beyond core **Media**. Out of the box the checkbox appears for the core **Image**
and **Responsive image** formatters; developers can extend it to other formatters
(like Blazy) with a small alter hook. Configuration is stored on the media bundle's
display, so it exports and deploys as config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

There's no configuration page. You enable the behavior on a media bundle's **Manage
display** page — for example
`/admin/structure/media/manage/image/display` — per view mode.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to your media bundle's **Manage display**, e.g.
   **Structure → Media types → Image → Manage display**
   (`/admin/structure/media/manage/image/display`). Pick the view mode you want
   (e.g. the one used when the media is embedded in content).
3. On the image field's row, make sure its **Format** is **Image** or **Responsive
   image**, then click the formatter **cog**.
4. Tick **Link to parent entity**, click **Update**, then **Save**.

The formatter summary will then read *"Link to parent entity (if media has a
parent)."* From then on, whenever that media is rendered as a referenced item and
its parent has a URL, its image links to the parent entity. When the media has no
parent (or the parent is brand-new / has no URL), the setting simply does nothing —
so it's safe to leave on.

A couple of notes:

- The checkbox only shows up for a **media** entity's **image** field using a
  supported formatter (**image** or **responsive_image** by default). It won't
  appear on other entity types or field types.
- The setting is stored in the media bundle's `entity_view_display` config, so you
  can export it and toggle it per environment. Developers wanting to support extra
  formatters (e.g. Blazy) can use
  `hook_media_parent_entity_link_alter_formatters()` — see the agent docs
  ([`agent/api/mechanism.md`](../agent/api/mechanism.md)).
