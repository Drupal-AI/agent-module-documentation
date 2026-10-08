# Image Background Formatter — manual setup guide

**Image Background Formatter** (`image_background_formatter`) adds a field
formatter that renders an image field as the **CSS background of a `<div>`** rather
than as an `<img>` tag. That is exactly what you want for hero and banner sections,
full-bleed cover images, and any CSS-driven layout where the image needs to sit
behind other content instead of standing alone in the document flow.

It is a pure display feature: you pick the formatter on an image field's *Manage
display*, and the image is rendered as a background respecting Drupal's normal file
access. There is no admin settings page and no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no separate configuration page** for this module — it has no global
settings form. You configure it per field on *Manage display*, described in "How to
use it" below.

## Where it lives in the admin menu

Image Background Formatter adds no admin page. You use it entirely from **Structure
→ Content types → *(your type)* → Manage display**, where it appears as a formatter
choice for image fields.

## How to use it

1. Go to the *Manage display* tab of the entity (a content type, media type,
   paragraph, etc.) that has the image field you want to render as a background.
2. In the **Format** column for that image field, choose **Image Background**
   (the formatter this module provides) instead of the default **Image**.
3. Click the gear icon to review any available formatter options (such as the image
   style used for the background), then **Update** and **Save**.
4. In your theme's CSS, size and position the resulting `<div>` as needed — the
   image is applied as its `background-image`, so properties like
   `background-size: cover` and a fixed height are typically what turn it into a
   hero banner.
