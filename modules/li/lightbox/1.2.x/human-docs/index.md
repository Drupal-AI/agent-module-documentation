# Lightbox — manual setup guide

**Lightbox** (`lightbox`) makes images on your site open in a **lightbox
overlay** — click a thumbnail and the full‑size image appears in a modal on top of
the page, instead of navigating away. It works by wrapping the image in a link
that points to the larger image, which the lightbox then opens.

It's worth knowing what this module is: a **base module**. On its own it provides
the shared groundwork, and the actual clickable lightbox formatters come from
companion modules built on top of it — **Lightbox Tobii Image Formatter** and
**Lightbox Fancybox Image Formatter**. This project also ships two submodules of
its own: **`lightbox_media`** (for use with core Media) and
**`lightbox_responsive`** (for responsive images).

You use it entirely from a field's display settings: pick the lightbox formatter
on an image field. Images continue to follow core's media and file access — the
module changes how images are *presented*, not who can see them, and it has no
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it (plus
   the submodule you need), and add a lightbox formatter module.

There is **no settings page** for this module — you configure it on your image
field's *Manage display*, described below.

## Where it lives in the admin menu

Lightbox adds no admin settings page of its own. You use it from **Structure →
Content types → *(type)* → Manage display** (or the equivalent Manage display for
any fieldable entity), where you choose the lightbox formatter for an image field.

## How to use it

1. Enable Lightbox, plus the submodule you need —
   `lightbox_media` if your images are core Media, or `lightbox_responsive` for
   responsive images.
2. Enable a lightbox **formatter** module on top of the base, such as **Lightbox
   Tobii Image Formatter** or **Lightbox Fancybox Image Formatter**.
3. Go to the **Manage display** tab of the content type (or entity) that has the
   image field.
4. Set that image field's format to the lightbox formatter, and configure its
   options (such as which image style is the thumbnail and which is the full‑size
   image).
5. View the content — clicking the thumbnail now opens the full image in a
   lightbox overlay.
