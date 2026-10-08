# PhotoSwipe — manual setup guide

**PhotoSwipe** (`photoswipe`) turns image and media fields into a sleek,
mobile‑friendly lightbox gallery powered by the [PhotoSwipe 5](https://photoswipe.com/)
JavaScript library. On the page your visitors see thumbnails; when they click one,
the full image opens in a fullscreen overlay they can swipe through, pinch to zoom,
and navigate with the keyboard. It is especially nice on phones and tablets.

You use PhotoSwipe by choosing one of its two **field formatters** on any image
field, or on a media/entity‑reference field, under *Manage display*:

- **Photoswipe** (`photoswipe_field_formatter`) — the standard formatter.
- **Photoswipe Responsive** (`photoswipe_responsive_field_formatter`) — the same
  thing, but sourced from core's Responsive Image module for art‑directed images
  (so it needs the **Responsive Image** core module enabled).

Each formatter lets you pick a **thumbnail image style** (what shows on the page),
optionally a different style for the **first** image, and a **lightbox image
style** (the large image inside the overlay). It also supports native lazy/eager
image loading, an optional download button, and an option to remove the gallery
wrapper class so several fields can be merged into one shared gallery. Multiple
values of a field are grouped into a single gallery automatically.

One important detail: the PhotoSwipe JavaScript library itself is **not** bundled
with the module. You provide it — either by installing it into `/libraries` with
Composer, or by turning on the built‑in **CDN** option on the settings form. The
installation guide covers both routes.

Global behaviour of the lightbox — animation style, zoom levels, background
opacity, tooltips, keyboard and touch bindings — lives on a settings form at
**Configuration → Media → PhotoSwipe**. A sub‑module, **PhotoSwipe Dynamic
Caption**, adds captions inside the lightbox.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, then provide the
   PhotoSwipe JavaScript library (locally or via CDN).
2. [Configuration](configuration/index.md) — apply a formatter to a field, choose
   image styles and gallery options, and tune the global lightbox settings.

## Where it lives in the admin menu

- The **global settings** form is at **Configuration → Media → PhotoSwipe**
  (`/admin/config/media/photoswipe`).
- The **formatters** are applied per field under **Structure → Content types →
  *type* → Manage display** (or any entity's Manage display, or in a View).
