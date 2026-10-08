# Enable and generate responsive image preloads

No settings page. Preloading is a per-formatter-instance toggle on core's **Responsive image**
field formatter.

## Enable via the UI

*Structure → Content types → {type} → Manage display* (or any entity's display), set the image
field's format to **Responsive image**, open the settings cog, check **Generate preloads**, Update, Save.

Only the `responsive_image` formatter gets the checkbox (`ThirdPartySettings::settingsForm()` guards on
`$plugin->getPluginId() === 'responsive_image'`). The formatter summary then shows "Preloads will be generated".

## Where the flag is stored

```
core.entity_view_display.<entity>.<bundle>.<view_mode>:
  content:
    <image_field>:
      type: responsive_image
      third_party_settings:
        responsive_image_preload:
          generate_preloads: true
```

Enable programmatically:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_image');
$c['third_party_settings']['responsive_image_preload']['generate_preloads'] = TRUE;
$vd->setComponent('field_image', $c)->save();
```

## Runtime pipeline

1. `hook_preprocess_field()` → `FieldPreprocessor::preprocessField($variables)` runs only when
   `$variables['element']['#formatter'] === 'responsive_image'`.
2. It loads the enabled `entity_view_display` for the entity/bundle/view_mode (falling back to `default`),
   reads the component, and proceeds only if `generate_preloads` is truthy.
3. `PreloadGenerator::generatePreloads($variables['element'])` iterates the rendered image items
   (`Element::children`), loading each item's `#item->entity` (file) and the item's
   `#responsive_image_style_id`.
4. For each breakpoint in the style's group and each multiplier mapping:
   - `sizes` mapping: builds a candidate per `sizes_image_styles` derivative → `url widthw`, and collects
     the `sizes` value into `imagesizes`.
   - `image_style` mapping: builds one candidate `url multiplier` (e.g. `… 2x`).
5. Emits a `#type => html_tag`, `#tag => link` element with attributes `rel=preload`, `as=image`,
   `imagesrcset` (comma-joined candidates), `media` (breakpoint media query, when present), and
   `imagesizes` (when a `sizes` mapping exists).
6. Preloads are attached to `$variables['#attached']['html_head'][]` keyed by
   `"{fileId}-{styleId}-{breakpointId}"`, so they bubble up into the page `<head>`.

## Notes / gotchas

- Scope it to hero/LCP images and specific view modes; preloading every image hurts performance.
- URLs come from `@file_url_generator` (`generateString`), so CDN/stream-wrapper rewrites are respected.
- Multi-value fields produce one preload set per delta.
- Requires core `responsive_image` and a configured responsive image style + breakpoint group.
