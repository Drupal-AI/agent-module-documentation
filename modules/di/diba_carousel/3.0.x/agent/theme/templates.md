<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme, template and CSS library

## Theme hook
`diba_carousel_theme()` registers one hook:

```php
'block__diba_carousel' => [
  'base hook' => 'block',
  'render element' => 'elements',
],
```

Template: `templates/block--diba-carousel.html.twig`. It receives `elements.content` = the
block's render array, i.e. `elements.content.items` (the slides), `elements.content.id` (the
unique DOM id) and `elements.content.config` (the full settings).

## What the template emits
Standard Bootstrap carousel markup:
- Outer `<div class="block diba-carousel {wrapper_class}">`, optional `<h2>` label.
- `<div class="carousel slide" data-ride="carousel" data-interval="{data_interval}">` — when
  `data_interval == 0` the attribute becomes `"false"` (no autocycle).
- `<ol class="carousel-indicators">` when `slides_count > 1` and `show_indicators`.
- `.carousel-inner` with one `.carousel-item` per slide. `items_by_slide > 1` wraps items in a
  `.row` of `.col-sm-{12/items_by_slide}` columns (`slides_count = ceil(items/items_by_slide)`).
- Per slide: optional `<img>` (wrapped in `url_image` link), and a `.carousel-caption` with the
  title (`<h2 class="caption-title">`, linked when `url` is set) and description.
- Prev/next `.carousel-control` anchors when `slides_count > 1` and `show_controls`.
- A `.carousel-more-link` block when both `more_link` and `more_link_text` are set.

## CSS library
`diba_carousel.libraries.yml` defines one library:

```yaml
diba-style:
  version: 1.x
  css:
    theme:
      assets/css/diba-carousel.css: {}
```

Referenced as `diba_carousel/diba-style`. It is **only attached from the template** when
`carousel_style == 'diba'` (`{{ attach_library('diba_carousel/diba-style') }}`), giving the
"Diba left captions" look (left-aligned semi-transparent caption panel over the image). The
`default` style attaches nothing extra.

## Bootstrap dependency (important)
The module ships **no JavaScript** and does not bundle Bootstrap. It only emits Bootstrap's
carousel HTML structure (Bootstrap 3/4/5 class names, `data-ride`/`data-slide` attributes,
`glyphicon` control icons). The sliding/autoplay behaviour requires the active theme to load
Bootstrap's CSS and JS (works with Bootstrap, Barrio and their subthemes). On a non-Bootstrap
theme the markup renders but does not animate unless you supply Bootstrap yourself.

## Overriding
Override `block--diba-carousel.html.twig` in your theme to change markup. The per-instance class
settings (`wrapper_class`, `image_class`, `row_class`, `col_class`, `title_class`,
`description_class`) let you add utility classes (e.g. `d-none d-sm-block`) without a template
override.
