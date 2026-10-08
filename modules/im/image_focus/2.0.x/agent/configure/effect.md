# Configure Image Focus

Two pieces: (1) add the effect to an image style, (2) an optional module setting.

## 1. The image effect

- Plugin id: **`image_focus_scale_crop`**, label "Focus Scale and Crop".
- Class `Drupal\image_focus\Plugin\ImageEffect\FocusScaleCropImageEffect` extends core `ResizeImageEffect`, so it takes the same **width** and **height** you give any resize/crop effect.
- Add it in the UI at *Configuration › Media › Image styles* (`admin/config/media/image-styles`): edit or create a style → *Add effect* → "Focus Scale and Crop" → set width/height.

Effect config schema (`image.effect.image_focus_scale_crop`, extends `image_size`):

| Key | Type | Notes |
|---|---|---|
| `width` | integer | target width (from `image_size`) |
| `height` | integer | target height (from `image_size`) |
| `face_detect` | boolean | present in schema; the shipped 2.0.x `applyEffect()` uses only the entropy focal-point method and does not read this flag |

### Algorithm (what it does on apply)

1. `getFocalPoint()` loads the source with `imagecreatefrom<ext>()` (jpg→jpeg). If GD can't load it, returns the geometric centre.
2. `ImageFocusEntropy` splits the image into square zones (size ≈ `max((w+h)/50, 10)`), computes each zone's RGB-histogram Shannon entropy, and returns the entropy-weighted centre of mass as `(cx, cy)`.
3. The effect scales so `width×height` fits (`scale = max(width/w, height/h)`), then `crop()`s a `width×height` box centred on the focal point, clamped to image bounds.

Because it decodes pixels through PHP GD directly on the source file, it functions with either the
GD or ImageMagick core toolkit.

## 2. Module setting

Route `image_focus.image_focus_settings` → `/admin/config/media/image-focus-settings`
(*Configuration › Media*), permission **`administer site configuration`**. Form
`ImageFocusSettingsForm`, config object `image_focus.settings`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `image_focus_face_detection_maxsize` | integer (min 50) | `50` | Max source image size in **KB** considered for the (slow) face-detection path. The README notes larger images are ignored; 2.0.x's effect runs the entropy method regardless. |

```bash
drush config:set image_focus.settings image_focus_face_detection_maxsize 200 -y
```
