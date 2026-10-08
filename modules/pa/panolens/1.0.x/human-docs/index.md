# Panolens — manual setup guide

**Panolens** (`panolens`) displays **360° panoramas** on your site using the
Panolens.js JavaScript library (built on top of Three.js and WebGL). It integrates
both libraries and provides **field formatters** so that panoramic images — and
panoramic video — render as interactive, pan/zoom/hotspot viewers that visitors
can look around inside, rather than as flat images.

It is a content-display feature: the panoramas are rendered client-side in the
browser, the underlying images and videos remain managed content that respects
normal file access, and the module has no access-control role of its own. Panolens
also ships some **Drush commands** to help with setup. It supports a wide range of
core versions (`^8` through `^11`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Panolens with Composer and
   enable it.

There is **no central settings form** — you turn on the panorama display per field
under **Manage display**, as described in "How to use it" below.

## Where it lives in the admin menu

Panolens adds no standalone admin page. You use it entirely from a field's
**Manage display** settings (for example **Structure → Content types → *(type)* →
Manage display**), where its panorama formatters become available.

## How to use it

1. Install and enable Panolens (see [Installation](installation/index.md)). It
   brings the Panolens.js and Three.js libraries with it.
2. On an entity that has an **image** (or video) field holding your panoramic
   media, open the bundle's **Manage display**.
3. Set that field's format to the **Panolens** panorama formatter — one for image
   panoramas, one for video panoramas.
4. Save, then view the content: the field renders as an interactive 360° viewer
   you can pan and zoom around.

> **Tip:** Panolens can only make a good panorama out of a genuine equirectangular
> (360°) source image or video. A regular photo displayed through the viewer will
> look distorted.
