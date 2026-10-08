# Advanced Image Media Attributes Formatter — manual setup guide

**Advanced Image Media Attributes Formatter**
(`advanced_image_media_attributes_formatter`) is a **field formatter** that adds
two performance-related HTML attributes to image and media field output:

- **`fetchpriority`** — a hint telling the browser to prioritize or deprioritize
  an image. Setting it to `high` on your hero / Largest Contentful Paint image can
  make the page feel like it loads faster.
- **`decoding`** — `async` or `sync`, controlling how the browser decodes the
  image relative to rendering the rest of the page.

It is a content-display feature that only affects the attributes on the image
markup. It does not change the content itself or any access rules, and has no
role in access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives

There is no global settings page. The formatter is chosen per field under
**Manage display**, and its `fetchpriority` / `decoding` options are set in that
formatter's settings.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the display you want to tune — for example **Structure → Content types →
   [your type] → Manage display** (or the equivalent for a media type).
3. For the image or media field, choose this module's formatter from the
   **Format** column.
4. Click the gear icon to open the formatter settings and set **fetchpriority**
   (e.g. `high` for a hero image) and **decoding** (`async` or `sync`).
5. Save. The chosen attributes now appear on the rendered `<img>` markup for that
   display.
