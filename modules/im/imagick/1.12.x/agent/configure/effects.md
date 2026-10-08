<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imagick image-style effects

Each effect is a standard core `ImageEffect` plugin (id `image_*`) that you add to an image
style at *Configuration → Media → Image styles* (`/admin/config/media/image-styles`), or in
config. At apply time each maps to an Imagick toolkit **operation** (`imagick_*`). They only
run when the active toolkit is `imagick` (see [toolkit.md](toolkit.md)).

## Effect plugin ids

`image_annotate`, `image_autorotate`, `image_blur`, `image_charcoal`, `image_coloroverlay`,
`image_colorshift`, `image_composite`, `image_convert`, `image_convolve`, `image_decipher`,
`image_define_canvas`, `image_edge`, `image_emboss`, `image_encipher`, `image_frame`,
`image_inverse`, `image_mirror`, `image_modulate`, `image_noise`, `image_oilpaint`,
`image_opacity`, `image_polaroid`, `image_posterize`, `image_rounded_corners`, `image_shadow`,
`image_sharpen`, `image_sketch`, `image_solarize`, `image_spread`, `image_strip`,
`image_swirl`, `image_transparent_background`, `image_trim`, `image_vignette`, `image_wave`.

Core-style resize/scale/crop/rotate/desaturate are also served through Imagick operations
(`imagick_resize`, `imagick_scale`, `imagick_crop`, `imagick_scale_and_crop`, …) when the
toolkit is active — you keep using the normal core effects.

## Example: blur effect

`image_blur` configuration (defaults): `type` (0 normal, 1 adaptive, 2 gaussian, 3 motion,
4 radial), `radius` `16`, `sigma` `16`, `angle` `0`.

## Add an effect in config (drush)

```php
$style = \Drupal::entityTypeManager()->getStorage('image_style')->load('thumbnail');
$style->addImageEffect([
  'id' => 'image_blur',
  'weight' => 1,
  'data' => ['type' => 2, 'radius' => '8', 'sigma' => '4', 'angle' => '0'],
]);
$style->save();
```

Or create a whole style:

```php
\Drupal::entityTypeManager()->getStorage('image_style')->create([
  'name' => 'my_style', 'label' => 'My style',
])->save();
```

Effects are stored inside the image style config (`image.style.<name>` → `effects`), each with
a plugin `id`, `uuid`, `weight`, and `data`. Schemas for the effect `data` shapes live in
`imagick.schema.yml` (e.g. `image.effect.image_blur`, `image.effect.image_composite`).

## Read it back

```bash
drush cget image.style.thumbnail effects
```
