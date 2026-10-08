# Varbase Media — manual setup guide

**Varbase Media** (`varbase_media`) is a feature module from the
[Varbase](https://www.drupal.org/project/varbase) distribution that layers extra
media behaviours on top of Drupal core's Media system. It is best understood as the
media layer of a Varbase-based site: it improves remote-video embedding, adds a
lightweight video player with a click-to-play overlay, wires CKEditor 5 media
resizing and responsive images together, and provides handy social-share-image
tokens.

It is a **behavioural / glue module** — almost all of its work happens automatically
through hooks, tokens, a filter override, and a Twig function. There is **no
settings page, no permissions, no routes, and nothing to configure**: enabling the
module is the setup. That also means it leans on things the wider Varbase
distribution provides (specific media types, image styles such as `social_large`,
and fields such as `field_media`); on a plain Drupal site those pieces are not
present, so the module is most at home inside Varbase.

The main things it does for you: it re-routes remote-video (YouTube/Vimeo) embeds
through core's oEmbed iframe with provider-aware templates (and fixes a Vimeo URL
quirk), overlays a play button on video thumbnails in content and Views, switches
CKEditor 5 media resizing to percentages with Large/Medium/Small presets on the
Full HTML format, hooks in `drimage_improved` for responsive images, and exposes
social-share-image tokens for Open Graph / Twitter cards.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no configuration page; what the module provides is described in *How to
use it* below.

## Where it lives in the admin menu

Nowhere directly — Varbase Media adds no admin pages, permissions, or settings. Its
effects appear wherever media is rendered: video embeds, the CKEditor 5 toolbar's
media resize options on the **Full HTML** text format, the Media Library, and the
tokens you can insert into Metatag fields.

## How to use it

Once enabled, most behaviours are automatic. The parts you actively reach for are
the tokens and (for developers) a Twig helper.

### Social-share-image tokens

Insert these tokens where a social/share image URL is expected — most commonly in a
**Metatag** Open Graph or Twitter-card image field:

- **`[media:social_large]`** — the media's image at 1200×630 (via the `social_large`
  image style).
- **`[media:social_medium]`** — 600×315 (`social_medium`).
- **`[media:social_small]`** — 280×150 (`social_small`).
- **`[node:share-image]`** — a smart node token that finds the best image
  automatically, checking `field_media`, then `field_image`, then `field_video`, and
  applying the `social_large` style. If a node has no suitable image, it falls back
  to the active theme's `share-image.png`. Use the plain `[node:share-image]` form.

(The `social_*` image styles and those media fields come from the Varbase
distribution, not from this module.)

### CKEditor 5 media resizing

On the **Full HTML** text format, editors get percentage-based media resizing with
named presets — **Large (100%)**, **Medium (50%)**, and **Small (25%)**. This is
active automatically when the CKEditor media-resize integration is present; there is
nothing to switch on. The underlying "Resize media images" filter is managed through
the `ckeditor_media_resize` module's filter on your text format.

### Video player and remote video

Video and remote-video media get a play-icon overlay on their cover
image/thumbnail, in both content and Views tables, and YouTube/Vimeo embeds render
through core's oEmbed iframe with provider- and view-mode-specific template
suggestions you can override in your theme.

### Responsive images in templates (developers)

A Twig function, `varbase_media_drimage(src)`, takes a raw image URL (for example a
Canvas/SDC-resolved image prop) and returns the `drimage_improved` data array for
client-side responsive rendering — or `NULL` if the URL does not resolve to a
managed file, in which case your template should fall back to a plain `<img>`.
