<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webp fallback image configuration (`wpf.settings`)

Config object `wpf.settings`. Form `Drupal\wpf\Form\SettingsForm` at `/admin/config/media/wpf`
(route `wpf.settings_form`, under *Configuration → Media*; the route requires the permission
`administer wpf configuration`).

## Keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `quality` | int | `75` | JPEG quality used when generating the fallback (passed to `imagejpeg()` / ImageMagick). |
| `styles.disabled` | array of image-style ids | `[]` | Image styles for which **no** JPEG fallback is generated (the WebP URL is left as-is). |

Shipped `config/install/wpf.settings.yml`:

```yaml
quality: 75
styles:
  disabled: []
```

(Note: the shipped `config/schema/wpf.schema.yml` only types `quality`; `styles.disabled` is written
by the form but not in the schema.)

## Via the UI

1. Go to **Configuration → Media → Webp fallback image settings** (`/admin/config/media/wpf`).
2. Set **Quality** (JPEG quality integer).
3. Expand **Image styles** and tick any styles under **Disable fallback image for styles** to skip
   fallback generation for them. Options come from `image_style_options(FALSE)`.
4. **Save configuration**.

## Via drush (scriptable)

```bash
drush cget wpf.settings                       # whole object
drush cget wpf.settings quality                # -> 75
drush cset wpf.settings quality 60 -y
```

Set disabled styles in PHP (the form stores a checkboxes map; a list of ids also works):

```php
\Drupal::configFactory()->getEditable('wpf.settings')
  ->set('quality', 60)
  ->set('styles.disabled', ['large' => 'large'])   // skip fallback for the 'large' style
  ->save();
```

`ImageFactory` reads `quality` (defaulting to 75 if unset) and `array_filter(styles.disabled)` at
construction, so an empty/absent value means "generate fallbacks for all styles".

## Prerequisites for it to do anything

- `responsive_image` enabled and a **responsive image style** in use in an entity display.
- Image styles that produce **WebP** derivatives (core "Convert" effect to webp).
- GD extension (or ImageMagick toolkit) available to perform the conversion.
