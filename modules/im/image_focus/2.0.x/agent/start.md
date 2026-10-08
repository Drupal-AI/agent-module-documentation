# Image Focus — agent index

Adds a **"Focus Scale and Crop"** image effect that auto-detects an image's focal point via an
entropy measure, so scale-and-crop image styles keep the salient region instead of centre-cropping.
Works with GD or ImageMagick toolkits. Depends on core `image`. No permissions, Drush, or plugin
types of its own.

- **Adding the effect to an image style, the effect id/algorithm, and the settings key** →
  [configure/effect.md](configure/effect.md)

Key facts:
- Image effect plugin id `image_focus_scale_crop` (`src/Plugin/ImageEffect/FocusScaleCropImageEffect.php`), extends core `ResizeImageEffect` — takes width/height, crops around the computed focal point (clamped to bounds).
- Focal point = entropy-weighted centre of mass of RGB-histogram zones (`src/lib/ImageFocusEntropy.php`); falls back to geometric centre if GD can't decode the source.
- Settings: config object `image_focus.settings` → `image_focus_face_detection_maxsize` (KB, default 50). Route `image_focus.image_focus_settings` at `/admin/config/media/image-focus-settings`, perm `administer site configuration`. (Effect schema also has a `face_detect` bool; 2.0.x effect uses entropy only.)
