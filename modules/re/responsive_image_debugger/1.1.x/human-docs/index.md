# Responsive Image Debugger — manual setup guide

**Responsive Image Debugger** (`responsive_image_debugger`) is a **developer
tool** that overlays the name of the Drupal image style directly onto each
displayed image, along with its dimensions. When you're working with responsive
images — the `<picture>` element, `srcset`, and `sizes` attributes — this makes
it easy to *see*, at a glance, which image variant the browser actually chose at
the current viewport, so you can confirm the right style is being served at each
breakpoint.

It works by replacing the core `ImageStyle` entity class and automatically adding
a "Text Overlay" image effect (from the **Image Effects** module) that stamps the
style name onto derivatives. Because of that, there is nothing to configure — you
enable it and the labels start appearing on responsive images throughout the
site. It works with the GD2, ImageMagick, and GraphicsMagick toolkits.

> **Important — do not use this on production.** During installation the module
> **removes the image styles folder in your site's public files directory**, and
> it overrides the `image_style` entity class. It also **conflicts** with any
> other module that overrides that class — notably **ImageAPI Optimize**
> (`imageapi_optimize`). Treat it strictly as a development / testing aid, and
> uninstall it before deploying.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — enabling it is all it takes.
See "How to use it" below.

## How to use it

1. On a **development or testing** environment (never production), enable the
   module as described in [Installation](installation/index.md).
2. Visit any page that renders responsive images. Each image now shows an overlay
   with its image‑style name and size.
3. Resize your browser (or use device emulation in your browser's dev tools) and
   watch the overlaid style names change as the browser selects different
   variants for each breakpoint — that's how you confirm your responsive image
   styles, `srcset`, and `sizes` are behaving as intended.
4. When you're done debugging, **uninstall the module** so the core image‑style
   class and your styles folder return to normal.
