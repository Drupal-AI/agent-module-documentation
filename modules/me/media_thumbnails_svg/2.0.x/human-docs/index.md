# Media Thumbnails SVG — manual setup guide

**Media Thumbnails SVG** (`media_thumbnails_svg`) fixes a common annoyance: when
you upload an SVG as a media entity, Drupal has no built‑in way to make a preview
image for it, so it shows a generic file icon instead of the artwork. This module
rasterizes the SVG into a real PNG thumbnail, so your logos, icons, and vector
illustrations get recognisable previews everywhere media thumbnails appear — the
Media Library, Views listings, entity‑reference pickers, and admin overviews.

It plugs into the [Media Thumbnails](https://www.drupal.org/project/media_thumbnails)
framework by adding a single thumbnail plugin (`media_thumbnail_svg`) that handles
the `image/svg` and `image/svg+xml` MIME types. When an SVG is uploaded, the
framework hands it to this plugin, which converts it to a PNG using the best
rasterizer available on the server — **GraphicsMagick** if present (best quality),
otherwise **ImageMagick**, and failing both, a pure‑PHP fallback (the
`meyfa/php-svg` library plus GD) that always works but handles only basic SVGs.
The resulting PNG becomes the media entity's `thumbnail`, which you can then place
in display modes or Views and run through any image style.

The module has **no configuration page of its own**. The output width and
background color are read from the parent Media Thumbnails settings (see *How to
use it* below). It also adds a line to the site's status report telling you which
rasterizer it detected on your server. There are no permissions, routes, or Drush
commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable it.

## Where it lives in the admin menu

The module adds no admin pages. Its behavior is controlled by the parent Media
Thumbnails settings at **Configuration → Media → Media thumbnails**
(`/admin/config/media/thumbnails`), and you can confirm which rasterizer is
active on the **status report** at *Reports → Status report*
(`/admin/reports/status`).

## How to use it

1. Make sure a media type accepts SVG uploads — for example, add the `svg`
   extension to the file field of the core **Document** media type, or create a
   dedicated media type for SVGs.
2. Upload an SVG to that media type. The framework automatically invokes this
   plugin and builds the PNG thumbnail; no extra step is needed.
3. To control the preview size or background, open **Configuration → Media →
   Media thumbnails**. The relevant settings are **width** (target thumbnail
   width in pixels, default 500, height keeps aspect ratio) and the background
   options — leave the background transparent, or turn it on to flatten SVGs onto
   a solid color of your choice. These settings belong to the Media Thumbnails
   module; this module simply reads them.
4. Changing the width or background only affects thumbnails generated *after* the
   change. To refresh existing previews, re‑save the media entities or clear
   caches.
