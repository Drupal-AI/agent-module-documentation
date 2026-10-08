<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Layout: Slideshow' paragraph type (drowl_paragraphs_bs_type_layout_slideshow)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_layout_slideshow -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `media_library:media_library`, `media_library_edit:media_library_edit`, `drupal:media`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_background_media`, `field_resp_imagestyle`, `field_settings`. Layouts (`.layouts.yml`) and slideshow options (`.layout_options.yml`) are provided as layout_options plugins.

## Layouts & options

`drowl_paragraphs_bs_type_layout_slideshow.layouts.yml` registers seven layouts (`..._1col`..`_6col` + `_custom`), each `\Drupal\layout_options\Plugin\Layout\LayoutOptions` with a single `slides` region and template under `templates/layouts/`. `.layout_options.yml` defines the per-layout options (autoplay, adaptive height, arrows, dots, infinite, center mode, and for the custom layout slides-per-breakpoint).

## `.module` (preprocess)

`..._preprocess_layout()` maps the theme hook / layout options to Slick settings, reading the global `drowl_paragraphs_bs.settings` `defaults.breakpoint_sizes.md/lg` and `defaults.layout_slideshow` fallbacks, then JSON-encodes them into `region_attributes.slides` as `data-slick` (via `Json::encode`). It warns (message + logger) when the md/lg breakpoints are unconfigured, and detects layout_paragraphs builder/preview mode to force-render empty regions. `..._preprocess_paragraph()` flags preview mode; a `theme_suggestions_paragraph_alter` unshifts the slideshow template suggestion.

## Templates

`templates/layouts/drowl-paragraphs-bs-slideshow--1col.html.twig` is the base layout (the 2-6 and custom templates extend it); it attaches `slick/slick.css` + `slick/slick.theme`, wraps each slide in `.slick__slide`, and renders custom prev/next arrows. `paragraph--drowl-paragraphs-bs--layout-slideshow.html.twig` extends the `layout` paragraph template.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
