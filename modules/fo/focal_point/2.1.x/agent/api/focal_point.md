# Focal Point API

Service `focal_point.manager` → `Drupal\focal_point\FocalPointManager`
(interface `FocalPointManagerInterface`). Wraps the Crop API to read/write a file's focal point.

```php
$manager = \Drupal::service('focal_point.manager');
```

## Methods (`FocalPointManagerInterface`)
- `validateFocalPoint($focal_point)` — returns bool; checks a `"x,y"` string is valid (0–100 each).
- `relativeToAbsolute($x, $y, $width, $height)` — convert stored %→pixel coords for an image size.
- `absoluteToRelative($x, $y, $width, $height)` — convert pixel click→stored % coords.
- `getCropEntity(FileInterface $file, $crop_type)` — load (or new) the `crop` entity for a file.
- `saveCropEntity(float $x, float $y, int $width, int $height, CropInterface $crop)` — persist the
  focal point (relative x/y percentages) onto the crop entity; returns the saved `CropInterface`.

## Example: set a focal point programmatically
```php
$manager = \Drupal::service('focal_point.manager');
$crop = $manager->getCropEntity($file, 'focal_point');   // crop type machine name
$manager->saveCropEntity(50.0, 33.0, $width, $height, $crop); // x%, y%
```

Focal point data is stored via the contrib **crop** module (`crop_type` = `focal_point`), so it is
decoupled from the file and survives image replacement. Hooks
`focal_point_entity_insert` / `_update` keep the crop entity in sync when host entities are saved.
