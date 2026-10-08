# SVG Pan Zoom — manual setup guide

**SVG Pan Zoom** (`svg_pan_zoom`) gives you an image‑field display formatter that
renders SVG images inside the
[svg-pan-zoom](https://github.com/ariutta/svg-pan-zoom) JavaScript library, so
viewers can drag to pan and scroll or double‑click to zoom around a vector image.
It is ideal for large, detailed vectors — floor plans, maps, circuit and network
diagrams, infographics — where a static image would be too small to read.

The problem it solves is that SVGs are perfect for zoomable detail but Drupal's
built‑in image formatters just render them flat. This module adds a **"Svg Pan
Zoom"** formatter that you set on an image field's display; every option the
library supports (pan, zoom, mouse‑wheel zoom, min/max zoom, sensitivity, fit,
contain, center, control icons, refresh rate) is exposed as a formatter setting.

It is configured **per view‑display**, not through a site‑wide settings form. It
depends on core's **Image** module, the contrib **SVG Image** module (so image
fields accept SVG uploads), and the external **svg-pan-zoom** JavaScript library
(version 3.6.1 or higher), which you install into your site's libraries
directory. There are no submodules. The module works without jQuery.

The formatter offers two display modes: **inline** mode prints the SVG file's
markup straight into the page, and **embed** mode wraps the file in an `<embed>`
element.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the svg-pan-zoom library and
   the module, and enable it.
2. [Configuration](configuration/index.md) — set the "Svg Pan Zoom" formatter on
   an image field's display and tune its options, field by field.

## How to use it

There is no admin settings page. You use the module by adding an image field that
accepts SVG (provided by SVG Image) to a content type, then on that content type's
**Manage display** screen choosing **Svg Pan Zoom** as the field's formatter and
adjusting its options. See [Configuration](configuration/index.md).
