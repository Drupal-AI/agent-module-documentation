# How per-breakpoint background CSS is generated

`ResponsiveBgImageFormatter::viewElements()` turns a responsive image style into many CSS
`background-image` rules, one per source/candidate, each scoped to its own media query. There
is no Twig template — output is CSS attached to the page head.

## Expansion pipeline

1. For each image file it builds `$vars` with `responsive_image_style_id = settings['image_style']`
   and the image dimensions (`getimagesize()` when the file exists), then calls core
   `template_preprocess_responsive_image($vars)` to populate `$vars['sources']`.
2. If `$vars['sources']` is empty the value is skipped.
3. It iterates `array_reverse($vars['sources'])`; each source's `srcset` is split into
   `url resolution` pairs.
4. For each candidate it takes the source's `media` attribute as the rule's media query.
   - `2x` candidates get an extra retina query appended:
     `... and (-webkit-min-device-pixel-ratio: 2), ... and (min-resolution: 192dpi)`.
   - It repairs a core bug by replacing the invalid `screen (max-width` with
     `screen and (max-width`.
5. It reuses the parent `getBackgroundImageCss($src, $css_settings)` to build the rule, then
   overrides `$css['media']` with the computed media query.

## Attaching to the page

Same mechanism as the parent formatter: each rule becomes an `html_tag`/`style` element with a
`media` attribute and a unique head key
`responsive_bg_image_formatter_css__<sha1(uuid, field name, image style, delta, src_i, source_i)>`.

- Normal requests: attached via `#attached['html_head'][]`.
- AJAX/XHR: rendered into `#attached['drupalSettings']['bg_image_formatter_css'][key]`, which the
  parent module's `hook_ajax_render_alter()` converts into `AddCssCommand`s.

Selectors are token-replaced (`\Drupal::token()->replace()`) and applied round-robin across
multivalue field values, as in the parent. An empty `$elements[0]` is emitted so the Views
renderer has something to render.
