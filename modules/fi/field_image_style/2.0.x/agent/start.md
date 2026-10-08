# Field Image Style — agent index

Adds an `image_style` **field type** (its value is an image-style machine name, chosen
from the site's image styles) plus an `image_style_image_formatter` for `image` fields that
renders using the style stored in such a field. No admin settings page (`configure=null`),
no permissions, no Drush, no plugin types. Depends on core `field` + `options`.

- **Create the image_style field, its storage settings (allowed_values, sort), widgets &
  formatters, and wire the image formatter** → [configure/field-and-formatter.md](configure/field-and-formatter.md)

Key facts: field type id `image_style` (extends Options `ListItemBase`, cardinality forced
to 1); default widget `options_select`, default formatter `list_default`; the display
formatter id is `image_style_image_formatter` (on `image` fields) whose `field_image_style`
setting names the `image_style` field to read the style from.
