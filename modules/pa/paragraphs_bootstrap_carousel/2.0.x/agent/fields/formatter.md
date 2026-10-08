<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter: `paragraphs_bootstrap_carousel_formatter`

Renders a **paragraphs reference field** as a Bootstrap 5 carousel. It applies to fields of type
`entity_reference_revisions` (the field type Paragraphs uses). Each referenced paragraph is loaded,
access-checked (`$entity->access('view')`), and turned into one slide.

- Plugin class: `Drupal\paragraphs_bootstrap_carousel\Plugin\Field\FieldFormatter\ParagraphsBootstrapCarouselFormatter`
  (extends `EntityReferenceFormatterBase`).
- Plugin id: `paragraphs_bootstrap_carousel_formatter`; label "Paragraphs boostrap carousel".
- Config schema: `field.formatter.settings.paragraphs_bootstrap_carousel_formatter`.

## Settings

| Key | Type | Default | Meaning |
|---|---|---|---|
| `view_mode` | string | `default` | View mode used to render each paragraph as the caption when no `caption` field is chosen (required). |
| `image` | string | `field_image` | **Required.** Which image field on the paragraph supplies the slide image. Options are the paragraph's `image`-type fields. |
| `image_type` | string | `original` | Bootstrap image class: `img-fluid`, `img-circle`, `img-default` (Image none), or empty = Original. Added to the `<img>` class. |
| `image_style` | string | `''` | Image style id; empty = original image. When set, the image is rendered via `#theme: image_style`. |
| `caption` | string | `''` | Which field supplies the caption text. Empty = render the whole paragraph in `view_mode` as the caption. Options limited to `list_string`, `text`, `text_long`, `text_with_summary`, `string`, `string_long` fields. |
| `link` | string | `field_link` | Which `link`-type field makes each slide clickable; empty = not clickable. The link title becomes the caption heading. |
| `interval` | integer | `5000` | Milliseconds between auto-advance (emitted as `data-bs-interval` per slide). |
| `pause` | boolean | `true` | Pause auto-cycle on hover (`data-bs-pause="hover"`). |
| `indicators` | boolean | `true` | Show the indicator dots. |
| `controls` | boolean | `true` | Show prev/next controls. |
| `wrap` | boolean | `true` | Loop (`data-bs-wrap`). |
| `cdn` | boolean | `false` | Attach the `paragraphs_bootstrap_carousel/bootstrap` CDN library (use only if the theme is not Bootstrap-based). |
| `custom_class` | string | `''` | Extra CSS class added to the `.carousel` container. |
| `ajax` | boolean | `false` | Present in schema/defaults but its form control is **commented out** in `settingsForm()` — effectively a no-op. |

## Runtime behavior

`viewElements()` returns one render element with `#theme => 'paragraphs_bootstrap_carousel'`,
`#items` from `getCarouselItems()`, and `#settings`. If `cdn` is on it attaches
`paragraphs_bootstrap_carousel/bootstrap`.

`getCarouselItems()` (per referenced paragraph):
- Loads the entity, and includes it only if `$entity->access('view')` is TRUE **and** it has the
  configured image field — so unpublished/denied paragraphs are skipped.
- Image: if `image_style` is set, builds a `#theme: image_style` element; otherwise renders the
  image field with view mode `full` (or falls back to `#theme: image` for a URL-only formatter).
  The classes `d-block w-100 carousel-image <image_type>` and the image `alt`/`title` are applied.
- Link: if a `link` field is chosen, `image_link` = `$linkField->first()->getUrl()->toString()`
  (wraps the slide image in an `<a>`), and `caption_title` = the link field's title.
- Caption: if a `caption` field is chosen, `caption_text` = that field's `->value`; otherwise the
  paragraph is rendered in `view_mode` and that becomes `caption_text`.

## Apply the formatter (no UI)

Set it on an entity view display. PHP example for a node's `field_slides` paragraphs field:

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'landing', 'default');
$display->setComponent('field_slides', [
  'type' => 'paragraphs_bootstrap_carousel_formatter',
  'settings' => [
    'view_mode' => 'default',
    'image' => 'field_image',
    'caption' => 'field_caption',
    'link' => 'field_link',
    'interval' => 5000,
    'indicators' => TRUE,
    'controls' => TRUE,
    'pause' => TRUE,
    'wrap' => TRUE,
    'image_style' => 'large',
    'cdn' => FALSE,
  ],
])->save();
```

Equivalent via config: edit `core.entity_view_display.<entity>.<bundle>.<mode>` so the component's
`type` is `paragraphs_bootstrap_carousel_formatter` with the same `settings`, then
`drush cim` (or `drush cset` the display config). There is no dedicated settings route.
