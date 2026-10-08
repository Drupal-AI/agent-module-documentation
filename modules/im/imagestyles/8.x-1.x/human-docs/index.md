# Image Style Preview — manual setup guide

**Image Style Preview** (`imagestyles`) shows what your image styles actually
produce, in one place. Drupal lists image styles by name and describes their
effects in words, but it never shows you the result — so answering "which of these
seventeen styles is the one used for card thumbnails?" means opening each style
and reading a chain of effect descriptions. This module renders the previews, so
that question becomes a matter of looking.

Rather than adding a settings page, it works on **media entity pages**: when you
view a media item (for example `/media/123`), the module displays the image
rendered through each of the site's image styles, side by side. That is exactly
where the pain is worst — a site that has grown styles over the years with names
like `medium_2`, `thumbnail_new`, and `card_v3` that no longer mean anything and
which nobody dares delete. Seeing them together is how that gets untangled.

Two practical notes. Its page is available to anyone with the broad **access
administration pages** permission — not strictly administrators — though all it
reveals is the site's own styles applied to a sample image, which is reasonable
for what it shows. And because previewing generates image derivatives, the
**first load** of a media page does the image processing for every style, so it
is slow once and fast afterwards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and switch on standalone media URLs.

There is **no configuration page** for this module — it has no settings form. The
previews appear on media entity pages, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. The previews render on individual media entity
pages (`/media/{id}`), so you view them by visiting a media item.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure **Standalone media URL** is enabled at **Configuration → Media →
   Media settings** (`/admin/config/media/media-settings`) — without it, media
   entities do not have their own viewable page.
3. Visit a media entity page, for example `/media/123`. You will see the image
   rendered through each configured image style, so you can compare them at a
   glance.

> **Expect a slow first load.** Generating the previews creates derivatives for
> every style, so the first view of a media page does that processing. Subsequent
> loads are fast.
