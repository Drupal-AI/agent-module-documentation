# Apply crops in code

Service `image_widget_crop.manager` → `Drupal\image_widget_crop\ImageWidgetCropManager`
(interface `ImageWidgetCropInterface`). Constructed with `entity_type.manager` +
`config.factory`.

```php
/** @var \Drupal\image_widget_crop\ImageWidgetCropManager $m */
$m = \Drupal::service('image_widget_crop.manager');

// $properties = ['x','y','width','height'] from the crop selection;
// $field_value = the image field value array (must contain file id / uri);
// $crop_type   = the crop type machine name.
$m->applyCrop($properties, $field_value, $crop_type);
$m->updateCrop($properties, $field_value, $crop_type);
$m->deleteCrop($file_uri, $crop_type, $file_id);
```

Key methods:
- `applyCrop($properties, $field_value, $crop_type)` — create a `crop` entity for the file.
- `updateCrop(...)` — update an existing crop's coordinates.
- `deleteCrop($file_uri, $crop_type, $file_id)` — remove a crop.
- `getCropOriginalDimension($field_values, $properties)` — map preview coords back to the
  original image dimensions.
- `buildCropToEntity()` / `getEffectData()` — helpers used by the widget.

Crops are standard **Crop API** entities, so you can also load/save them via
`\Drupal::entityTypeManager()->getStorage('crop')` and `Crop::findCrop($uri, $type)`.
