# Webp fallback image — manual setup guide

**Webp fallback image** (`wpf`) lets you serve modern **WebP** images to browsers that
support them while still giving older browsers a **JPEG** fallback — using Drupal's
Responsive Image module's built-in `<picture>` / `srcset` fallback slot. Modern visitors
get smaller, faster WebP; everyone else gets a working JPEG.

The clever part is *how* it makes the fallback. Rather than pre-generating JPEGs that
might never be used, `wpf` creates the `.jpg` copy **lazily** — only when a browser
actually requests that fallback URL — and it derives the JPEG straight from the WebP
derivative, so the WebP stays your primary, best-quality asset. When Responsive Image
renders a `<picture>` element, `wpf` rewrites the fallback `<img>` so it points at a
`.jpg` version of the WebP; the first time that URL is hit, the module generates the
JPEG (using PHP's GD extension, or ImageMagick) at a quality you configure.

The intended pipeline is: convert your images to WebP inside your **image styles**
(core's "Convert" effect to webp), attach those styles through a **responsive image
style**, and use that responsive image style in an entity display. `wpf` handles the
rest, and it also cleans up orphaned fallback JPEGs when the source file is deleted or a
crop changes.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   and its dependencies.
2. [Configuration](configuration/index.md) — the settings page (JPEG quality, disabling
   fallback per image style) and the responsive-image setup it needs to do anything.

## Where it lives in the admin menu

The settings page is at **Configuration → Media → Webp fallback image settings**
(`/admin/config/media/wpf`), gated by the *Administer wpf configuration* permission.
