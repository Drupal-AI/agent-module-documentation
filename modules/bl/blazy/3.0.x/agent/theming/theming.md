# Blazy theming

- Theme hook: `blazy` (registered in `blazy_theme()`), template `templates/blazy.html.twig`,
  render element `element`. Preprocess: `template_preprocess_blazy()` in `blazy.module`.
- Blazy also preprocesses core render output to inject lazy attributes:
  `blazy_preprocess_image()`, `blazy_preprocess_responsive_image()`,
  `blazy_preprocess_file_video()`, `blazy_preprocess_file_audio()`,
  `blazy_preprocess_media_oembed_iframe()`, `blazy_preprocess_field()`,
  `blazy_preprocess_views_view()`.

Override the markup by copying `blazy.html.twig` into your theme. Available variables include
the image/media element, `attributes`, `item_attributes`, `settings` (lazy, ratio, blur), and
the URL/placeholder. Aspect-ratio boxes and blur/LQIP are driven by `settings.ratio` and
`settings.blur` and the `css/` assets shipped in `blazy.libraries.yml`.

Library alters: `blazy_library_info_alter()` / `blazy_library_info_build()` let Blazy swap the
loader library (native vs bLazy vs IntersectionObserver polyfill). CKEditor CSS is adjusted via
`blazy_ckeditor_css_alter()`.
