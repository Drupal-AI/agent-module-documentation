# Juicebox — manual setup guide

**Juicebox** (`juicebox`) turns image, file, and media fields — or the results of
a View — into a rich, responsive HTML5 image gallery: swipeable on touch devices,
fullscreen-capable, and with thumbnails and captions. It's a bridge between Drupal
and the third-party **Juicebox** JavaScript gallery library.

There are two ways to render a gallery. The **field formatter** ("Juicebox
Gallery") attaches to an image, file, or media entity-reference field on any
entity's display — so a multi-value image field on an Article becomes a gallery.
The **Views style** ("Juicebox Gallery") turns a whole View's rows into a single
gallery — handy for a portfolio or photo-album listing. Either way, the module
builds a gallery, emits a Juicebox XML feed, and attaches the JavaScript that
draws the gallery in the browser.

Each display has its own settings: which image styles to use for the main image
and the thumbnails, where captions and titles come from (image alt, title,
filename, or file description), and common Juicebox options like gallery
dimensions, colors, buttons, and link behaviour — plus a manual-configuration
escape hatch for advanced/Pro-only options. A global settings form controls markup
filtering, CORS embedding, interface translation, and the multi-size image-style
mapping. The module also installs four ready-made image styles
(`juicebox_small`, `juicebox_medium`, `juicebox_large`, `juicebox_square_thumb`).

One important thing: the Juicebox JavaScript library itself is downloaded and
licensed separately (a free "Lite" and a paid "Pro" edition) and must be placed
under `/libraries/juicebox/` for a gallery to actually render in the browser. You
can set everything up in config without it, but the live gallery won't appear
until the library is present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on the release:** the installed 4.0.x release is `4.0.0-alpha2`, an
> alpha. The plugin IDs and settings are stable across the 4.0.x branch, but treat
> it as pre-release and pin explicitly if you depend on it.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the external JavaScript library.
2. [Configuration](configuration/index.md) — set up a gallery display (formatter
   or Views style) and the global settings.

## Where it lives in the admin menu

The global settings form is at **Configuration → Media → Juicebox**
(`/admin/config/media/juicebox`). Gallery *displays* are configured on each
entity's **Manage display** screen (for the formatter) or in a View's **Format**
settings (for the Views style).

## How to use it

1. Install the module and drop the Juicebox JavaScript library into
   `/libraries/juicebox/` (see [Installation](installation/index.md)).
2. Either set an image/file/media field's format to **Juicebox Gallery** on a
   **Manage display** screen, or set a View's Format to **Juicebox Gallery**.
3. Adjust the per-display settings and, optionally, the global settings.

See [Configuration](configuration/index.md) for the details.
