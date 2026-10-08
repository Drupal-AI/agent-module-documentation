# Background Image — manual setup guide

**Background Image** (`background_image`) gives you an integrated UI for putting
background images on your site — a single global image, a different image per
entity or content type, per path or route, or behind a Views page. The 3.x branch
is built on Drupal core's **Media** module (you upload images as a *Background
Image* media type) and the **Context** module (you decide *where* each image
shows using context conditions). On top of the basics it offers polished effects:
a scroll‑triggered **blur**, a **full‑viewport** hero treatment, formatted
**overlay text**, an automatic **dark** body class so you can flip text colors on
dark images, and responsive/retina delivery with a preload fallback color to
avoid a flash before the image loads.

Practically, images are managed as reusable Media entities, and each background
image carries its own settings (blur mode and radius, full‑viewport, dark,
preload color, and overlay text with a text format). The module injects a
**"Background Image" region** into every theme, provides **Background Image** and
**Background Image (text)** blocks, and adds a **Background Image context
reaction** so you can attach an image to any context you define. The generated CSS
comes from a Twig template you can override per theme, and several alter hooks let
developers customize the CSS, the rendered element, and the overlay text.

The module has a settings form, but at present it exposes just one option — the
CSS **base class** used to prefix the generated classes. Almost all real
configuration happens on the individual background image items and through image
styles and Context, which is why this guide covers usage here rather than in a
separate configuration page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Media and Context.

## Where it lives in the admin menu

The (small) settings form is at **Configuration → Media → Background Image**
(`/admin/config/media/background_image`). Background images themselves are managed
as Media, and placement is configured through the **Context** UI (Structure →
Context).

## How to use it

### 1. Grant the permission

Background Image adds one permission, **Administer background image**, which is
marked security‑restricted — it gives full control over background image entities
and settings, so grant it only to trusted admin roles. (The settings form itself
is gated by core's *Administer site configuration*.) Media upload/library access
is governed by the core Media module's own permissions.

### 2. Upload a background image

Add a background image (uploaded as the *Background Image* media type). On the
add/edit form you set that image's own options:

- **Blur** — none, on scroll, on scroll + full‑viewport, or always, plus radius
  and speed.
- **Full viewport** — render it as a full‑viewport hero behind the page.
- **Dark** — mark the image dark so a `-dark` body class is added and your theme
  can switch text colors.
- **Preload color** — a solid fallback color shown while the image loads.
- **Overlay text** — formatted heading/CTA text rendered over the image.

### 3. Choose where it shows

Each background image has a **type** (global, per entity, per bundle, per path,
per route, or per view) and a target that determine where it applies. The
recommended way to place images is the **Context** module: create a context, add
conditions (path, route, entity bundle, and so on), and add the **Background
Image** reaction to pick the image for that context. Alternatively, place the
**Background Image** or **Background Image (text)** block, or render the
auto‑injected **Background Image** theme region.

### 4. Tune styles (optional)

Responsive, preload, and fallback image styles are configured centrally in the
module's settings config (`background_image.settings`), and matching image styles
plus a responsive style ship with the module. To change the generated CSS, drop a
`background_image.css.twig` into your theme's `templates/` directory, or use
`hook_background_image_css_template_alter()`.
