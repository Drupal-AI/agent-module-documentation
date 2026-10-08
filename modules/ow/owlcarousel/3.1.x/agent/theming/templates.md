# Owl Carousel theming

## Theme hooks & templates

`owlcarousel_theme()` registers:
- **`owlcarousel`** — template `owlcarousel.html.twig`, variables `items`, `settings`. Used by the
  field formatter. `template_preprocess_owlcarousel()` wraps each item in
  `<div class="owl-item-inner owl-item-innerN">`, adds classes `owl-slider-wrapper owl-carousel
  owl-theme` and the `data-settings` JSON attribute.
- **`owlcarousel_views`** — template `owlcarousel-views.html.twig`, no variables of its own. Used
  by the Views style. `template_preprocess_owlcarousel_views()` builds `data-settings` (with
  `JSON_FORCE_OBJECT`), adds the same wrapper classes, attaches the `owlcarousel/owlcarousel`
  asset library, then calls `template_preprocess_views_view_unformatted()`.

## The `data-settings` attribute

Both templates put the carousel options (after `_owlcarousel_format_settings()` casts them and
folds the responsive breakpoints) on the wrapper as a JSON `data-settings` attribute.
`js/owlcarousel.js` reads it to call `.owlCarousel(settings)`. So to change behaviour you change
the formatter/view settings, not the template.

## Asset library

`owlcarousel/owlcarousel` (in `owlcarousel.libraries.yml`) loads the library's
`dist/assets/owl.carousel.css` + `owl.theme.default.css`, the module's `owl.transitions.css`, then
`js/jquery-compat.js`, the library's `dist/owl.carousel.js`, and `js/owlcarousel.js`. It depends on
`core/jquery`, `core/drupal`, `core/drupalSettings`, `core/jquery.once`.

## Overriding markup

Override `owlcarousel.html.twig` / `owlcarousel-views.html.twig` in your theme to change the
wrapper markup — keep the `owl-carousel owl-theme` classes and the `data-settings` attribute so
the JS still initialises the slider.
