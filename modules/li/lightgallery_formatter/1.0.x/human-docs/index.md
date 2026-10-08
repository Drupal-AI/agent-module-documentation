# LightGallery Formatter — manual setup guide

**LightGallery Formatter** (`lightgallery_formatter`) is a field formatter that
displays a **media reference field** as an interactive
[lightGallery](https://www.lightgalleryjs.com/) lightbox: thumbnails that open a
full‑screen gallery with zoom, fullscreen, keyboard navigation, and touch/swipe
gestures on mobile. It supports mixed content in a single gallery — images plus
YouTube and Vimeo videos — using Drupal core's Media.

Its defining idea is **reusable gallery profiles**. Instead of configuring every
field separately, you create named profiles (each with its own transition,
controls, and behavior), then simply pick a profile when you set the formatter on
a field. Change the profile once and every gallery using it updates. Profiles are
standard Drupal configuration, so they export and sync between environments like
any other config.

Unlike the separate [lightGallery](https://www.drupal.org/project/lightgallery)
module, this one is described by its maintainers as **zero‑dependency**: it bundles
the lightGallery assets it needs, so there are no manual library downloads or
Composer path juggling. All settings are chosen through UI checkboxes and
dropdowns — no lightGallery JSON to hand‑write.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally add the preview and demo submodules.
2. [Configuration](configuration/index.md) — create and tune reusable gallery
   profiles, then apply one to a media field.

## How to use it

1. Create one or more **gallery profiles** (see [Configuration](configuration/index.md)).
2. Go to **Structure → Content types → *(your type)* → Manage display** for a
   bundle that has a **media reference field**.
3. In the **Format** column for that field, choose the **LightGallery Formatter**.
4. In the formatter settings, select the **profile** you want the gallery to use.
5. Save the display. The media field now renders as a lightGallery gallery driven
   by that profile's settings.
