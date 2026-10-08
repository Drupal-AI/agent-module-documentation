# API: generateMediaQueries()

Class `Drupal\responsive_background_image\ResponsiveBackgroundImage`. One static method — the entire module.

```php
public static function generateMediaQueries(
  string $css_selector,
  $entity,                              // ContentEntityBase (with the image field) OR File
  ?string $field_machine_name,          // image field name; pass NULL when $entity is a File
  string $responsive_image_style_machine_name,
  string $media_entity_field_machine_name = 'field_media_image'  // only for Media fields with a custom image field
): array|false
```

- `$css_selector` — CSS selector the background applies to, WITHOUT braces. Make it unique (include the entity
  id) so multiple instances on a page don't collide, e.g. `'.paragraph--id--' . $paragraph->id() . ' .hero__image'`.
- `$entity` — a `ContentEntityBase` holding an Image field (`image` type) or a Media reference
  (`entity_reference` → media) field, or a `File` entity directly.
- Returns a render-array element for `html_head`, or **`FALSE`** (logged to channel `responsive_background_image`)
  when the target id is empty, the referenced media/file is missing, or the field type is neither image nor
  entity_reference.

## Return shape

```php
[
  [
    '#tag' => 'style',
    '#value' => Markup::create($all_media_queries), // Markup so & in URLs isn't escaped
    '#weight' => 99999,
  ],
  'responsive-background-image-' . $entity_id . '-' . $uuid, // unique head element key
]
```

Assign it to `$vars['#attached']['html_head'][]` or it has no effect.

## Generated CSS

- A base `selector { background-image: url(fallback); }` when the Responsive Image Style has a fallback image
  style (skipped for `_empty image_`; uses the original file for `_original image_`).
- One `@media <breakpoint query> { selector { background-image: url(...); } }` per image-style mapping at 1x.
- The same at 2x with `and (min-device-pixel-ratio: 1.5)` for mappings whose multiplier is not `1x`.

Breakpoint media strings come from the Responsive Image Style's breakpoint group; image URLs are built with the
mapped image style (`ImageStyle::buildUrl`) and passed through `file_url_generator` `transformRelative()`.

## Typical usage

```php
use Drupal\responsive_background_image\ResponsiveBackgroundImage;

function mytheme_preprocess_paragraph(&$vars) {
  $p = $vars['paragraph'];
  if ($p->bundle() === 'hero' && !$p->get('field_hero_background_image')->isEmpty()) {
    $css = 'paragraph--id--' . $p->id();
    $vars['attributes']['class'][] = $css;
    $style = ResponsiveBackgroundImage::generateMediaQueries(
      '.' . $css . ' .hero__image', $p, 'field_hero_background_image', 'hero_paragraph'
    );
    if ($style) {
      $vars['#attached']['html_head'][] = $style;
    }
  }
}
```

Requires a Responsive Image Style using the "Select a single image style" option per breakpoint (the `sizes`
multi-style option is not supported). Add `background-size: cover;` etc. in your own CSS.
