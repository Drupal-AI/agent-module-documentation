<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Slideshow (responsive_slideshow) — agent index

Content-driven slideshow for **Bootstrap 5 themed sites**. Version **3.0.0**, core `^9.4 || ^10 || ^11`,
one declared dependency: core `image`. License GPL-2.0-or-later.

## What it actually is (not a field formatter)

Installing the module (`responsive_slideshow_install()`) does three things:

1. Creates and **locks** a `responsive_slideshow` content type (via `config/install`) with fields
   `field_slideshow_image` (image, required), `field_slide_teaser` (text), `field_body_desc`
   (text, long), `field_slide_link` (link), `field_hide_external_link` (boolean).
2. Creates the image style `responsive_slideshow_style` — `image_scale_and_crop` to **1320x347**,
   upscale on. (The README's "1272x335" is stale; the shipped config is 1320x347.)
3. Seeds `responsive_slideshow.settings`: `responsive_slideshow_no_of_slides` 5,
   `responsive_slideshow_description_length` 180, `responsive_slideshow_interval` 5000.

Rendering is done by a **Block plugin**, not a formatter — `Drupal\responsive_slideshow\Plugin\Block\SlideshowBlock`
(id `responsive_slideshow`, admin_label "Responsive Slideshow", category "Blocks"). Its `build()`
calls the procedural `responsive_slideshow_homepage()` in `responsive_slideshow.module`, which
queries published slideshow nodes and returns a `#theme => 'slideshow_data'` render array attaching
the `responsive_slideshow/responsive-styling` CSS library, with `#cache max-age 0` (uncached).

## The JS is not here

`responsive_slideshow.libraries.yml` defines **one** library, CSS only
(`css/responsive_slideshow.css`). There is **no bundled slider JavaScript**. The template emits
standard Bootstrap 5 carousel markup (`data-bs-ride="carousel"`, `.carousel-indicators`,
`.carousel-control-prev/next`) and relies on the **site's Bootstrap 5 theme** to provide Bootstrap's
own JS. On a non-Bootstrap theme the markup renders but does not animate — establish the theme first.
No external CDN is loaded, so there is no SRI concern.

## Strategic notes

- **The value is entirely in the qualifier.** On a Bootstrap site the framework's JS/CSS are already
  loaded, so driving its carousel adds no library, no weight and no styling to override. Anywhere else
  this is the wrong tool.
- **Bootstrap's carousel has acknowledged accessibility limitations** — auto-advance with no
  accessible pause control, un-announced transitions. For a conformance obligation, disable
  auto-advance (interval) and verify keyboard operation.
- **Content past the first slide is largely unseen.** Build one on the merits.

## Where to look next

- [configure/index.md](configure/index.md) — settings form, install/uninstall behavior, the bundled
  content type, fields, and image style.
- [blocks/index.md](blocks/index.md) — the block plugin, the query in `responsive_slideshow_homepage()`,
  link resolution, and the carousel template.
- [permissions](../data.json) — one permission, `administer responsive slideshow`, gates only the
  settings form. Placing the block uses core `administer blocks`; authoring slides uses core node
  permissions on the `responsive_slideshow` bundle.

## Security

Output escaping in the slide markup: alt and title are `Html::escape()`d before Twig (Twig
re-escapes; harmless double-escaping), title and description are `strip_tags`'d, body goes through
the `restricted_html` format, and Twig autoescapes the link href. Access is core-gated (block =
`administer blocks`, settings = `administer responsive slideshow`, slides = core node permissions).
