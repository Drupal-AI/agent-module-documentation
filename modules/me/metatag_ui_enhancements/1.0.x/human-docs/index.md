# Metatag UI Enhancements — manual setup guide

**Metatag UI Enhancements** (`metatag_ui_enhancements`) improves the way images and
social-media previews are managed in the [Metatag](https://www.drupal.org/project/metatag)
module. Out of the box, the social previews generated for links shared to platforms
like LinkedIn, X (Twitter), Facebook, and Pinterest can be incomplete or
inconsistent. This module addresses that by giving editors sensible **default
suggestions** for the title, description, and image, better token handling, and
**Media Library** integration for picking the preview image.

The idea is a smoother, more reliable social-preview experience: the page title and
website title form the preview heading, the featured media image supplies the
preview image, and the page or news summary supplies the description — each of which
an editor can override with different text or a different image. It also lets you
manage a **generic fallback image** that displays when a page has no image of its
own, and it groups these controls under a dedicated **"SEO and social media"** tab
for back-end usability.

It depends on the Metatag module and core's **Media Library**. It is an SEO/display
feature that shapes the metadata emitted for a page; it has no content or
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Metatag / Media Library dependencies.

The module works through Metatag's own configuration and per-entity forms rather
than a separate settings page — see "How to use it".

## Where it lives in the admin menu

The module enhances the existing Metatag configuration and adds a dedicated **"SEO
and social media"** tab for editors. Image defaults are managed through the Metatag
defaults, using the Media Library to pick images.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. In the Metatag configuration, set your **default** title, description, and image
   suggestions — including the **generic fallback image** used when a page has no
   image of its own. Images are chosen through the Media Library.
3. When editing content, use the **"SEO and social media"** tab to review the
   suggested title/description/image and override any of them where a specific page
   needs different values.

> **Tip:** If you override the page title, keep it close to the link text used to
> share the page — matching link text and title is a UX/content best practice.
