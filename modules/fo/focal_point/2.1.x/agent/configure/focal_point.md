# Configure Focal Point

![Focal Point Scale and Crop image-style effect](../../../../../../../screenshots/focal_point/2.1.x/effect.png)

No dedicated settings page. Configuration is done on **image styles** and the **field widget**.

## 1. Enable the focal-point widget on an image field
Manage form display for the entity/bundle (e.g. `/admin/structure/types/manage/article/form-display`)
and set the widget for your image field to **Image (Focal Point)** — plugin
`focal_point_image_widget` (`src/Plugin/Field/FieldWidget/FocalPointImageWidget.php`).
Editors then see a crosshair over the preview and an X,Y field (values are percentages, e.g. `50,50`).
Widget setting: `preview_link` / `preview_image_style` control the preview dialog's style.

## 2. Add a focal-point effect to an image style
At `/admin/config/media/image-styles`, edit or add a style and add one effect:

- **Focal Point Crop** — `focal_point_crop` — crop to an exact width×height around the point.
- **Focal Point Crop by width/height** — `focal_point_crop_by_ratio` — crop to a ratio/one dimension.
- **Focal Point Scale and Crop** — `focal_point_scale_and_crop` — scale then crop (most common for
  fixed teaser/thumbnail sizes; upscaling optional).

(Plugins in `src/Plugin/ImageEffect/`, base class `src/FocalPointEffectBase.php`.)
Any style that includes one of these effects will crop around the saved focal point.

## Preview
The widget's **Preview** link opens a dialog rendering the image through every image style that
uses a focal-point effect (route `focal_point.preview`,
`FocalPointPreviewController`), so editors can verify all crops at once.

## Config schema
`config/schema/focal_point.schema.yml` defines schema for the widget + effect settings; patterns
are stored as normal image-style/field config and are fully exportable.
