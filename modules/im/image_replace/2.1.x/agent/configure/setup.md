# Setting up image replacement

Two configuration steps, then it runs automatically on entity save + derivative generation.

## 1. Add the "Replace image" effect to a style
Go to *Admin → Config → Media → Image styles* (`/admin/config/media/image-styles`), edit or
create a style, add effect **Replace image** (`image_replace`). Only styles that contain this
effect become available as replace targets.
- On style save, `image_replace_image_style_presave()` writes the style's own machine name into
  the effect config at `effects.{key}.data.image_style` so the effect knows which style it is
  running for (config key `image.effect.image_replace`, schema key `image_style`).
- `_image_replace_style_options()` returns exactly the styles that have this effect (labels
  `Html::escape`d).

## 2. Map source fields on the image field
Edit an **image field** instance (Manage fields → the field → Edit,
`field_config_edit_form`). `image_replace_form_field_config_edit_form_alter()` adds a collapsed
**Image replace** fieldset with one `select` per replace-enabled style, listing the *other*
image fields on the same entity/bundle as candidate **source_field** values.

Stored as a field third-party setting:
```yaml
# field.field.{entity}.{bundle}.{field} config
third_party_settings:
  image_replace:
    image_style_map:
      large:
        source_field: field_mobile_image
```
Meaning: when `field` is rendered with the `large` style, use the image from
`field_mobile_image` (same delta) instead.

Programmatic equivalent:
```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node','article','field_hero');
$field->setThirdPartySetting('image_replace','image_style_map', [
  'large' => ['source_field' => 'field_mobile_image'],
]);
$field->save();
```

## What happens on entity save (`image_replace_entity_presave`)
For every content entity, for each image field on its bundle that has a non-empty
`image_style_map`:
- Collects target field URIs and the mapped source field URIs (matched by delta).
- Calls `image_replace.storage`: `remove($style,$targetUri)` then, if a source URI exists at
  that delta, `add($style,$targetUri,$sourceUri)` — syncing the `{image_replace}` table.
- Calls `image_path_flush($uri)` on all involved URIs to drop stale derivatives.

## What happens at render (derivative generation)
`ImageReplaceEffect::applyEffect()` calls
`image_replace.storage->get($configuration['data']['image_style'], $image->getSource())`. If a
replacement URI is found, it loads that file via `ImageFactory` (same toolkit) and runs the
`image_replace` toolkit operation, which swaps the source image resource (GD:
`setImage($replacementResource)`; ImageMagick: sets source/width/height from the replacement).
No mapping → returns TRUE unchanged (original image used).

## After changing a mapping
The field form's element validate (`image_replace_form_field_config_edit_form_element_validate`)
warns, when the field already has data, that you must **re-save existing content** to rebuild
the mapping (the table is only updated on entity save) and that browser/intermediate HTTP caches
may still serve the old derivative (on live sites the only reliable bust is re-uploading under a
new filename). Bulk-resave via the admin content list / a VBO save action.

## Notes
- No global config form (`configure` null); everything is per-style + per-field.
- Requires core `image`. ImageMagick operation additionally needs `drupal/imagemagick`.
