# Crop entity API

There is no separate factory service — the API lives as static + instance methods on the
`crop` content entity (`Drupal\crop\Entity\Crop`, interface `Drupal\crop\CropInterface`).

## Look up crops (static)
```php
use Drupal\crop\Entity\Crop;

Crop::cropExists($uri, $type = NULL);              // bool — does a crop exist for this file URI?
$crop = Crop::findCrop($uri, $type);               // CropInterface|NULL — by URI + crop type
$crop = Crop::getCropFromImageStyleId($uri, $sid); // CropInterface|NULL — resolve via image style's crop_crop effect
```
`findCrop()` delegates to the crop storage handler (`CropStorageInterface::getCrop()`).
`Crop::getCropFromImageStyle($uri, ImageStyle)` still exists but is **deprecated** — use
`getCropFromImageStyleId()`.

## Create / update a crop
```php
$crop = Crop::create([
  'type' => 'my_crop_type',   // crop_type bundle
  'entity_id' => $file->id(),
  'entity_type' => 'file',    // provider plugin id
  'uri' => $file->getFileUri(),
]);
$crop->setPosition($x, $y)    // center coordinates
     ->setSize($width, $height)
     ->save();
```
On save, if `uri` is empty it is resolved via the entity provider; derivatives are flushed
unless `crop.settings:flush_derivative_images` is FALSE.

## Read geometry (instance)
- `position()` → `['x' => int, 'y' => int]` (center)
- `anchor()` → `['x', 'y']` (top-left corner, derived from center − size/2)
- `size()` → `['width' => int, 'height' => int]`
- `provider()` → the `EntityProviderInterface` for this crop (throws `EntityProviderNotFoundException`)
- `getShortHash()` → 8-char hash of position+anchor (used for URL cache-busting)

The entity is revisionable and translatable; base fields: `cid`, `vid`, `type`, `entity_id`,
`entity_type`, `uri`, `x`, `y`, `width`, `height`.
