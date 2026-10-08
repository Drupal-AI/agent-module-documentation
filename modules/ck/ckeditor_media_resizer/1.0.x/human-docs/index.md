# CKEditor 5 Media Resizer — manual setup guide

**CKEditor 5 Media Resizer** (`ckeditor_media_resizer`) lets content editors
resize embedded media images inside CKEditor 5 — either by dragging handles on the
image or by typing exact dimensions into a small form. Think of it like resizing
an image in a word processor: grab a corner, drag, and the dimensions are saved
with your content.

The gap it fills is that Drupal has no built‑in way to resize an embedded media
image in the editor. Out of the box an embedded image renders at its original size
or the size dictated by its view mode, and changing that otherwise means creating
extra view modes, editing image styles, or hand‑editing raw HTML. This module puts
that control directly in the editor.

When an editor selects an embedded image, an overlay with eight directional
handles (corners and edges) appears; dragging any handle resizes the image in real
time with a live width × height label. A toolbar button opens a balloon form —
styled like CKEditor's native panels — where editors can type exact values in
several CSS units (px, %, em, vw, vh), lock the aspect ratio when working in
pixels, or use one‑click scale presets (25%, 50%, 75%, 100%, and an "Original"
button). Administrators can set minimum and maximum width limits so editors can't
make images absurdly small or large — that is the one thing worth configuring, and
it is covered in [Configuration](configuration/index.md). The plugin even handles
media nested inside container widgets such as column layouts.

The approach is non‑destructive. Resize dimensions are stored as
`data-media-width` and `data-media-height` attributes on the `<drupal-media>` tag;
the original media entity is never touched. An included text filter, **Apply
resize dimensions to embedded media**, reads those attributes at render time and
applies responsive‑friendly inline styles (the width you set, plus
`max-width: 100%` and `height: auto`) to the `<img>` on the front end. The module
has no access‑control role, but note it is *minimally maintained* and **not
covered by the Drupal security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the button to a text format,
   enable the render filter, and set the min/max width limits.

## Where it lives in the admin menu

There is no standalone settings page. You set it up per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`): add the resizer button to the CKEditor 5
toolbar, enable the render filter, and set width limits in the plugin's settings.
See [Configuration](configuration/index.md).
