# Image Field Caption — agent guide

Adds an optional rich-text caption to core **image** fields. It does not create a new
field type: it re-classes the core `image` field item, adds per-field settings, injects a
`text_format` caption element into the image widget, and ships an "Image with caption"
formatter. Captions live in their own DB tables, not the field columns.

There is **no admin settings page** (no `configure` route), no permissions, no Drush.

- [configure/image_field_caption.md](configure/image_field_caption.md) — enable captions on a field, required flag, choose the formatter, theming/CSS.
- [api/image_field_caption.md](api/image_field_caption.md) — the `image_field_caption.storage` service, its methods, the widget value shape, and DB tables.
- [hooks/image_field_caption.md](hooks/image_field_caption.md) — the core hooks the module implements (info alter, widget alter, entity load/insert/update/delete, theme).
