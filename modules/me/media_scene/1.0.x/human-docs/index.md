# Media Scene — manual setup guide

**Media Scene** (`media_scene`) lets content editors turn any block of content into
a visually rich "scene" by placing it in front of a background image — all from the
standard **CKEditor 5** editing experience. If you have ever wanted a hero banner,
a themed content divider, or a call-to-action panel without editing Twig templates,
writing CSS, or asking a developer, this is the module that makes it possible.

It adds three toolbar buttons to CKEditor 5 for any text format you enable them on:

- **Add Background Image** — opens Drupal's native **Media Library** (restricted to
  the image media type) so editors can pick an existing image or upload a new one.
- **Background Scene Settings** — configures one scene's appearance: an explicit
  width and height in pixels, an **overlay tint** color with adjustable opacity to
  keep text readable, a **focal point** chosen from a 9-position grid to control
  what stays visible when the image is cropped, and an optional **parallax**
  (fixed-attachment) scrolling effect.
- **Remove Background Image** — clears the background and returns the content to its
  normal flow.

A background stores a reference to the **media entity**, not a frozen copy of the
image. So if the media item is replaced, or the configured image style changes,
every page that uses that background updates automatically on its next render. The
styling also travels with the content if it is moved, duplicated, or reused inside
Paragraphs or other entities.

It depends only on core modules — **Media**, **Media Library**, **CKEditor 5**, and
**Editor** — with no external JavaScript libraries, third-party services, or API
keys.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — add the toolbar buttons to your text
   formats, enable the render filter where needed, and choose the image style on
   the optional settings page.

## Where it lives in the admin menu

Two admin areas matter. The buttons are turned on per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). The module's own optional settings page — where
you pick an image style for backgrounds — sits at **Configuration → Media → Media
Scene** (`/admin/config/media/media-scene`).

## How to use it

Once the buttons are on a text format's toolbar, editing is entirely in-place:
click **Add Background Image**, pick an image from the Media Library, then click
**Background Scene Settings** to set the size, overlay tint, focal point, and
parallax. Day-to-day use needs only Drupal's standard **View media** permission —
editors do not need any administrative rights to create scenes.
