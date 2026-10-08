# Add the Image Style Quality effect

There is no settings page. You add the `image_style_quality` **image effect** to an image style
(Admin → Configuration → Media → Image styles → *edit style* → add effect "Image Style Quality"),
or in code/config.

## The effect

- Plugin id: `image_style_quality` (label "Image Style Quality").
- Config schema `image.effect.image_style_quality`: single key `quality` — integer **0–100**,
  default **75** (`defaultConfiguration()`).
- Order it **after** resize/scale/crop effects in the style's pipeline.

## Add it in code

```php
use Drupal\image\Entity\ImageStyle;

$style = ImageStyle::load('thumbnail');           // or ImageStyle::create([...])
$style->addImageEffect([
  'id'     => 'image_style_quality',
  'weight' => 10,                                  // run late
  'data'   => ['quality' => 60],
]);
$style->save();
```

The effect's configuration lives under `data` in the style's `effects` list:
`configuration = ['id' => 'image_style_quality', 'data' => ['quality' => 60], 'weight' => 10, 'uuid' => ...]`.

## Read it back

```bash
drush cget image.style.thumbnail effects
# find the effect whose id is image_style_quality and read data.quality
```

Or: iterate `$style->getEffects()`, match `getPluginId() === 'image_style_quality'`, read
`$effect->getConfiguration()['data']['quality']`.

## How it works

`applyEffect()` does not modify the image bytes. It calls
`$configFactory->get(<toolkit config_object>)->setModuleOverride([<config_key> => $quality])`, so
the active toolkit encodes **this derivative** at the chosen quality. The toolkit → config mapping
comes from the `mutable_quality_toolkits` plugin (see
[../plugins/mutable-quality-toolkits.md](../plugins/mutable-quality-toolkits.md)). It therefore
affects whatever format that toolkit quality setting governs (typically JPEG, and WebP where the
toolkit maps quality to it).
