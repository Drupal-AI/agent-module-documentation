<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter: `animated_gif_image_url`

Class `Drupal\animated_gif\Plugin\Field\FieldFormatter\AnimatedGifImageUrlFormatter`, extends
core's `ImageUrlFormatter`.

```php
#[FieldFormatter(
  id: 'animated_gif_image_url',
  label: 'Animated GIF URL to image',
  field_types: ['image'],
)]
```

- Applies to **image** fields. Configured like core's "URL to image" formatter (`image_url`) — pick
  an image style; the value output is a URL string, not an `<img>`.
- Difference from core: in `viewElements()`, for each referenced file that
  `AnimatedGif::isFileAnAnimatedGif()` reports as animated, it replaces the styled derivative URL
  with the **original file URL** (`fileUrlGenerator->transformRelative(generateString($uri))`), so
  the URL points at the un-styled, still-animated GIF. Non-animated images keep the normal styled
  URL from the parent formatter.
- Config schema: `field.formatter.settings.animated_gif_image_url` extends
  `field.formatter.settings.image_url` (same settings: `image_style`, `image_link`).

## Set it on a display

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_image');
$c['type'] = 'animated_gif_image_url';
$vd->setComponent('field_image', $c)->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_image` → look for
`type: animated_gif_image_url`.

> You often do **not** need this formatter: just enabling the module makes the normal image /
> responsive-image formatters bypass styles for animated GIFs (see
> [hooks/rendering.md](../hooks/rendering.md)). Use `animated_gif_image_url` when you specifically
> want the URL-to-image output and want animated GIFs to yield their original URL.
