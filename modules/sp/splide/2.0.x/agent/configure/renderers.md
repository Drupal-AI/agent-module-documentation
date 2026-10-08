<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering a slider: formatters, Views style, filter

Three ways to render content through a Splide optionset. All select an optionset by id and run
through the Blazy-based `splide.formatter` / `splide.manager`.

## Field formatters

Set one on an entity's *Manage display*. Each formatter exposes an **optionset** select plus
image-style / caption / grouping options (via the shared `SplideAdmin` form).

| Formatter id | Field types |
|---|---|
| `splide_image` | image |
| `splide_media` | entity_reference (media) |
| `splide_file` | file / image |
| `splide_text` | text (renders text items as slides) |
| `splide_entityreference` | entity_reference |
| `splide_paragraphs_media` | entity_reference_revisions (paragraphs) |
| `splide_paragraphs_vanilla` | entity_reference_revisions (paragraphs) |

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_images', [
  'type' => 'splide_image',
  'label' => 'hidden',
  'settings' => ['optionset' => 'default', 'image_style' => 'large'],
])->save();
```

The component's `settings.optionset` names the `splide.optionset.<id>` to use.

## Views style

Add a Views display and choose **Format → Splide Slider** (style plugin id **`splide`**). The style
settings let you pick the optionset and map fields to slide image/caption/overlay. Splide X ships a
demo View (`views.view.splide_x`) as a working example.

## Text-filter shortcode

Enable the **Splide** filter (`splide_filter`, a reversible transform filter) on a text format, then
author a `[splide]`-style shortcode in body content to render a slider inline. See
`src/Plugin/Filter/FILTER_TIPS.txt` for the exact shortcode syntax.

## Notes

- All renderers require the **Blazy** module and the Splide JS library in `/libraries`.
- The optionset's `skin`, `group` (for asNavFor thumbnail pairing), autoplay, breakpoints, etc. come
  from the optionset config, not the formatter — so change the slider behavior by editing the
  optionset, and reuse it across many fields/views.
