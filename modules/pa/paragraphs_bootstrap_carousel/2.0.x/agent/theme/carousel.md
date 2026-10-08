<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hook, template & Bootstrap library

## Theme hook

`hook_theme()` in `paragraphs_bootstrap_carousel.module` registers:

- hook: `paragraphs_bootstrap_carousel`
- template: `templates/paragraphs-boostrap-carousel.html.twig` (note the misspelled "boostrap")
- variables: `id_field_name` (defaults to `'paragraphs-boostrap-carousel'`; the formatter passes the
  host field's machine name), `items` (the slide objects built by the formatter), `settings` (the
  formatter settings array).

Override by copying the template into your theme, or `hook_theme_suggestions` / preprocess as usual.

## What the template emits

Outer `<div class="carousel slide {custom_class}">` with `id="{id_field_name}"` and Bootstrap 5 data
attributes (with the BS4 equivalents alongside for compatibility): `data-bs-ride="carousel"`,
`data-bs-wrap` (from `wrap`), `data-bs-pause="hover"` (from `pause`).

- Indicators: rendered when `settings.indicators`, one `<button data-bs-slide-to>` per slide.
- Slides: `.carousel-inner` → per item `.carousel-item` with `data-bs-interval="{interval}"`; the
  image (`item.image`) is optionally wrapped in `<a href="{item.image_link}">`; the caption block
  `.carousel-caption.d-none.d-md-block` shows `<h3>{item.caption_title}</h3>` (the link title) and
  `<p>{item.caption_text}</p>` (the mapped caption field, or the rendered paragraph view mode).
- Controls: prev/next `<button>`s with `.visually-hidden` labels, rendered when `settings.controls`.

The markup is Bootstrap-5-shaped; it renders on any theme but only animates where Bootstrap's
carousel JavaScript is loaded.

## Bootstrap library

`paragraphs_bootstrap_carousel.libraries.yml` defines one library:

- `paragraphs_bootstrap_carousel/bootstrap` — Bootstrap **5.2.3**, loaded from the jsdelivr CDN
  (`bootstrap.bundle.min.js` + `bootstrap.min.css`) as external assets with SRI `integrity` hashes
  and `crossorigin: anonymous`, plus a small local `css/drupal.css`.

This library is attached **only** when the formatter's `cdn` setting is enabled (intended for themes
that are not already Bootstrap-based). When your theme already ships Bootstrap 5, leave `cdn` off so
no second copy loads. The module bundles no local Bootstrap build.
