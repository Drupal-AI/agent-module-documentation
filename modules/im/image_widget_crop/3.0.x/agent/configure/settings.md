# Configure the crop widget

## Per-field widget (form display)
Set the field's widget to **ImageWidget crop** on the entity's *Manage form display*.
Widget settings (schema `field.widget.settings.image_widget_crop`):

| Setting | Meaning |
|---|---|
| `crop_list` | Crop types (from the `crop` module) offered on this field. |
| `crop_types_required` | Which of those crop types the editor MUST define. |
| `crop_preview_image_style` | Image style used for the crop preview. |
| `preview_image_style` | Preview style for the uploaded image. |
| `progress_indicator` | Upload progress (`throbber`/`bar`). |
| `show_crop_area` | Always expand the crop area. |
| `warn_multiple_usages` | Warn if the file is used elsewhere. |

Crop types themselves (aspect ratios, hard/soft limits) are defined by the **crop** module
at `/admin/config/media/crop`. Each crop type needs a matching image style with the
"Manual crop" (`crop_crop`) effect to render.

## Global settings
Config object `image_widget_crop.settings` (key `settings`), UI at
`/admin/config/media/crop-widget` (route `image_widget_crop.crop_widget_settings`,
`administer site configuration`). Read/write: `drush config:get image_widget_crop.settings`.

| Key | Default | Meaning |
|---|---|---|
| `library_url` | '' | External Cropper JS URL (if not bundling locally). |
| `css_url` | '' | External Cropper CSS URL. |
| `crop_preview_image_style` | `crop_thumbnail` | Default preview style. |
| `crop_list` | `[]` | Default crop types. |
| `crop_types_required` | `[]` | Default required crop types. |
| `warn_multiple_usages` | FALSE | Warn on shared files. |
| `show_default_crop` | TRUE | Show a default crop selection. |
| `notify_apply` | FALSE | Message when a crop is applied. |
| `notify_update` | TRUE | Message when a crop is updated. |

The Cropper library is declared in `image_widget_crop.libraries.yml`
(`image_widget_crop/cropper` + `cropper.integration`).
