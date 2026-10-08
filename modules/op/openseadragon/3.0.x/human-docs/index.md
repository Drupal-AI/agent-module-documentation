# OpenSeadragon Viewer — manual setup guide

**OpenSeadragon Viewer** (`openseadragon`) displays image and file fields as
**deep‑zoom, pan‑and‑zoom tiled images** using the OpenSeadragon JavaScript library.
Instead of loading one huge image, the viewer streams just the tiles it needs from an
external **IIIF image server**, so visitors can smoothly zoom into very
high‑resolution scans — manuscripts, maps, artworks, museum objects — without
downloading enormous files. It's part of the Islandora ecosystem and is a natural fit
for archives and GLAM (galleries, libraries, archives, museums) sites, but it works on
any Drupal site with a IIIF server available.

There are two ways to show a viewer. The first is a **field formatter**: on any image
or file field's *Manage display*, choose the OpenSeadragon format and each file becomes
a zoomable tile source. The second is a **block** that renders a viewer from a **IIIF
Presentation manifest** — you enter the manifest URL when placing the block (it can
contain tokens like `[node:nid]` to build per‑node manifests), and the module fetches
and parses it into tile sources. Multi‑page objects can display in sequence (paged)
mode with previous/next controls, and several images can show together in a collection
grid.

Both paths share one **site‑wide viewer configuration**. That's where you set the
required IIIF server URL and tune the viewer's behavior — and OpenSeadragon exposes a
lot of behavior: zoom limits, pan and gesture handling per input device, a mini‑map
navigator, rotation and full‑page controls, sequence and collection modes, and much
more. You configure it once and it applies to every viewer on the site.

The OpenSeadragon library itself loads from a CDN, and the image tiles come from your
IIIF server (such as Cantaloupe), so there's nothing extra to download to your server.
The module also registers JP2 and TIFF mime mappings so those formats work as Drupal
media.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the site‑wide settings form, the field
   formatter, and the manifest block.

## Where it lives in the admin menu

Its settings form is at **Configuration → Media → OpenSeadragon settings**
(`/admin/config/media/openseadragon`). The formatter is chosen on each field's
**Manage display**, and the block is placed under **Structure → Block layout**.

## How to use it

1. Have a **IIIF image server** (for example Cantaloupe) reachable from your site.
2. Install and enable the module.
3. On the settings form, enter your IIIF server's base URL and adjust any viewer
   options.
4. Either set an image/file field's display format to **OpenSeadragon**, or place the
   **OpenSeadragon block** with a IIIF manifest URL.

The full walkthrough is in [Configuration](configuration/index.md).
