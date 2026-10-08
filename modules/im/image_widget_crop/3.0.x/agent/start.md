# image_widget_crop — agent start

Adds a Cropper-based crop widget to image fields, storing crops via the Crop API (`crop`
module). Depends on `crop` + core `image`. Global config UI: **Admin → Config → Media →
Image Crop Widget** (`/admin/config/media/crop-widget`, route
`image_widget_crop.crop_widget_settings`).

- Global settings + per-field widget settings → [configure/settings.md](configure/settings.md)
- Apply/update/delete crops in code (manager service) → [api/manager.md](api/manager.md)
- Example content type / demo submodule → image_widget_crop_examples
