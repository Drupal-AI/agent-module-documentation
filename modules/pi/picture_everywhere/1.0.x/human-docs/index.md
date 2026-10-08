# Picture Everywhere — manual setup guide

**Picture Everywhere** (`picture_everywhere`) is a plug‑and‑play override for
Drupal's image templates and preprocessing that forces every image to be rendered
as an HTML `<picture>` element instead of a bare `<img>` tag. The moment you
enable it, image output across the site becomes consistent: you never have to
wonder whether a given image element will come out as an `<img>` or a `<picture>`
— it's always a `<picture>`.

Why would you want that? Mainly it is a developer convenience and a
future‑proofing move. The `<picture>` element's main strength is offering browsers
a choice of image formats and sources, and standardising on it now means that when
the next new image format comes along (as WebP did), serving it is far easier on a
site that already uses `<picture>` everywhere. It integrates automatically with
the **SVG Image Field** module if that is installed.

It works out of the box with **no required configuration** — enable it and image
markup changes site‑wide. It also offers one **optional enhancement** aimed at
sites that pair it with the WebP module, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no required configuration page** — the override takes effect as soon as
the module is enabled. The optional WebP enhancement is described under "How to
use it" below.

## Where it lives in the admin menu

Picture Everywhere adds no settings you have to visit — it works automatically
once enabled. It affects only image markup; it has no content or access‑control
role.

## How to use it

Just enable it. From that point on, images that Drupal would normally render as
`<img>` are rendered as `<picture>` instead.

### Optional WebP enhancement

On sites that still support older browsers and therefore need to serve PNG/JPG
*and* WebP, the usual approach requires creating duplicate WebP image styles and
wiring them together through the Responsive Image module. Picture Everywhere can
instead add a `.webp` `<source>` automatically for every JPEG and PNG, which the
separate **[WebP](https://www.drupal.org/project/webp)** module then serves. This
lets you reserve the Responsive Image module for images that genuinely need art
direction.

This enhancement is **disabled by default** and is **not recommended** for sites
that no longer need to support browsers without WebP support — for those sites,
simply include WebP conversion in your image styles as usual. You can still run
Picture Everywhere on its own to prepare for future image formats.
