<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Carousel Image Formatter (bootstrap_carousel_if) — agent index

A single **field formatter** that renders a multi-value **image field** as a **Bootstrap 5
carousel**. Package `Field types`. Core requirement `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 4.0.2 (version-dir 4.0.x).

- **The formatter, every setting, the markup/library it emits, and how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `BootstrapCarouselImageFormatter` (id **`bootstrap_carousel_image_formatter`**,
  label *"Bootstrap Carousel"*) in
  `src/Plugin/Field/FieldFormatter/BootstrapCarouselImageFormatter.php`, extending the image
  module's `ImageFormatterBase`. `field_types = { "image" }` — it targets **core image fields
  only**. Best on a multi-value image field.
- No field type, no widget, no routes, no permissions, no Drush, no `.services.yml`, no config
  objects, **no `config/schema/`** (formatter settings are stored as field-display third-party
  config with no shipped schema). No `.libraries.yml`.
- `bootstrap_carousel_if.module` implements only `hook_help()` and `hook_theme()` (registers the
  `bootstrap_carousel` theme hook). It changes only how an image field is **displayed**, selected
  per view-display on *Manage display*.

## Dependencies

- `info.yml` declares only `drupal:file`. The formatter class extends `Drupal\image\…\ImageFormatterBase`
  and targets the `image` field type, so the core **image** module is required in practice even
  though it is not declared.
- **Bootstrap itself is NOT bundled.** The module emits Bootstrap 5 carousel markup
  (`data-bs-*` attributes) and ships no CSS/JS. The **theme must load Bootstrap's carousel
  JS + CSS**; with CSS only, the carousel renders but will not advance.

## Rendering (from source)

- `viewElements()` calls `getEntitiesToView()` (honors image display/access), builds one slide
  per file as a `#theme => 'image_formatter'` render array with the chosen `image_style`, merges
  image-style + file **cache tags**, and passes `#theme => 'bootstrap_carousel'` with `#slides`,
  `#interval`, `#pause`, `#wrap`, plus `#indicators`/`#controls` **forced to `0` when there is
  only one slide**.
- Each slide's caption `title` is taken from the image field item's own **Title** value
  (`$items[$delta]->getValue()['title']`). The template also supports `slide.description`, but
  `viewElements()` never populates it, so only the image Title becomes a caption.
- `templates/bootstrap-carousel.html.twig` generates a random DOM id
  (`bs-carousel-{{ random(1000,9999) }}`), emits `.carousel-indicators`, `.carousel-inner` with
  one `.carousel-item` per slide, `.carousel-caption` (`<h5>` = title), and prev/next controls.
  All dynamic values (`title`, `interval`, etc.) go through Twig **auto-escaping**.

## Settings (formatter `defaultSettings()`)

Configurable in `settingsForm()`: `interval` (ms, default `5000`), `pause` (pause on hover),
`wrap`, `indicators`, `controls`, `image_style`. Stored-but-not-exposed: `background`,
`background_pos`, `keyboard`, `height`, `width`. Full detail in
[fields/formatter.md](fields/formatter.md).
