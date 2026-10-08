# Imagick — manual setup guide

**Imagick** (`imagick`) gives Drupal an alternative image toolkit backed by the
PHP **Imagick** (ImageMagick) extension, and adds roughly 35 extra image‑style
effects that the default GD toolkit cannot produce. Drupal core ships a GD
toolkit; Imagick registers a second toolkit that processes images through the
in‑memory `Imagick` PHP extension rather than shelling out to the `convert`
binary the way the separate ImageMagick module does.

Because it works on in‑memory image data, Imagick can offer effects GD has no
equivalent for — blur, charcoal, emboss, oil paint, polaroid frames, vignettes,
drop shadows, watermark/compositing, color overlays, format conversion (for
example to WebP), and many more. Each of these is an ordinary image effect
plugin, so you add it to any image style exactly like a core effect, and image
styles stay portable config that exports and imports normally.

Enabling the module changes nothing on its own: images render the same until you
switch the site's active toolkit to Imagick and/or add its effects to an image
style. The one hard requirement is that the **Imagick PHP extension** is
installed on the server.

This guide is written for a **human** setting Imagick up through the admin UI. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   confirm the Imagick PHP extension is present, and enable it.
2. [Configuration](configuration/index.md) — select the Imagick toolkit, tune its
   settings, and add its effects to image styles.

## Where it lives in the admin menu

Once enabled, you select the toolkit and set its options at **Configuration →
Media → Image toolkit** (`/admin/config/media/image-toolkit`). Its extra effects
are added on individual image styles at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`).

## How to use it

Switch the site's active image toolkit to Imagick, adjust the default JPEG
quality and other output options if you wish, then add any of the extra effects
to your image styles. From that point Drupal generates image derivatives through
ImageMagick, with your chosen effects applied. See
[Configuration](configuration/index.md) for the details.
