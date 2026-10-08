# Responsive Image Preload — manual setup guide

**Responsive Image Preload** (`responsive_image_preload`) is a small performance
add-on for core's **Responsive image** field formatter. When you flag a field, the
module emits `<link rel="preload" as="image">` tags into the page `<head>` — complete
with the right `imagesrcset`, `imagesizes`, and `media` attributes matching the
field's responsive image style — so the browser can start fetching the correct image
derivative as early as possible. The typical payoff is a better **Largest Contentful
Paint (LCP)** score for above-the-fold hero and banner images.

The best part is that there is nothing to hand-write and no admin settings page. You
enable it per field, per display, with a single checkbox that appears in the
Responsive image formatter's settings. The module figures out the correct preload
markup from the responsive image style and its breakpoints — including per-breakpoint
`sizes` and `image_style` mappings and multipliers — and keeps it in sync
automatically if the style or breakpoints change.

Preloading everything would hurt performance rather than help it, so scope this to
the images that matter — your hero or LCP image, usually only in the full page view
mode, not in teasers. The module depends only on core's **Responsive Image** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Preloading is a per-formatter toggle on core's **Responsive image** formatter, so
you turn it on wherever that formatter is used:

1. Go to the relevant **Manage display** tab — for a content type this is
   **Structure → Content types → *(your type)* → Manage display**
   (`/admin/structure/types/manage/<type>/display`). It works for any fieldable
   entity (nodes, media, block content, etc.).
2. Set the image field's **Format** to **Responsive image** (and pick a responsive
   image style if you have not already).
3. Click the settings cog on that field's row and tick **Generate preloads**.
4. Click **Update**, then **Save**. The formatter summary will now show "Preloads
   will be generated", and the rendered page emits the preload `<link>` tags in its
   `<head>`.

The **Generate preloads** checkbox only appears on the *Responsive image* formatter —
no other image formatter offers it. Because it is a per-display setting, you can
enable it in the full view mode and leave it off in teasers, so only the important
image on each page is preloaded.
