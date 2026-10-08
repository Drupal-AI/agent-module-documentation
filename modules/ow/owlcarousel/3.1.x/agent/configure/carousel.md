# Configure an Owl Carousel

No settings page. You configure a carousel in one of two places; both use the same option set and
store it in normal display/view config (no config schema is shipped, so values are plain scalars).

## A. Image field formatter — `owlcarousel_field_formatter`

On a bundle's *Manage display*, set a multi-value **image** field's format to **"OwlCarousel
Carousel"**. Stored in the field component of
`core.entity_view_display.<entity>.<bundle>.<mode>`:

```yaml
content:
  field_gallery:
    type: owlcarousel_field_formatter
    settings:
      image_style: large        # image style id ('' = original)
      image_link: ''            # '' | content | file
      items: 3
      margin: 10
      nav: true
      autoplay: false
      autoplayHoverPause: false
      loop: true
      dots: true
      rtl: false
      dimensionMobile: 480
      itemsMobile: 1
      dimensionDesktop: 1200
      itemsDesktop: 4
```

Set via PHP:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_gallery', [
  'type' => 'owlcarousel_field_formatter',
  'label' => 'hidden', 'weight' => 0, 'region' => 'content',
  'settings' => ['items' => 3, 'loop' => TRUE, 'nav' => TRUE, 'dots' => TRUE, 'margin' => 10],
])->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_gallery`.

## B. Views style — `owlcarousel`

In a view's Format, choose **"OwlCarousel"** as the style. The same options appear in the style's
settings form and are stored in the view display's `style.options`. Rows render through the
`owlcarousel_views` theme.

## The options (shared, from `OwlCarouselGlobal`)

| Key | Type | Meaning |
|---|---|---|
| `items` | int | Items visible per slide (formatter default falls back to 3). |
| `margin` | int | Pixel gap between items. |
| `nav` | bool | Show prev/next arrows. |
| `dots` | bool | Show pagination dots (default true). |
| `autoplay` | bool | Auto-advance slides. |
| `autoplayHoverPause` | bool | Pause autoplay on hover. |
| `loop` | bool | Infinite loop. |
| `rtl` | bool | Right-to-left. |
| `itemsMobile` / `dimensionMobile` | int / px | Items shown at/below the mobile breakpoint. |
| `itemsDesktop` / `dimensionDesktop` | int / px | Items shown at/above the desktop breakpoint. |
| `image_style` | string | (formatter only) image style id. |
| `image_link` | string | (formatter only) `''` / `content` / `file`. |

At render, `_owlcarousel_format_settings()` casts these (ints/bools), folds the mobile/desktop
pairs into a `responsive` map, drops `image_style`/`image_link`, and JSON-encodes the rest into the
wrapper's `data-settings` attribute for OwlCarousel2.
