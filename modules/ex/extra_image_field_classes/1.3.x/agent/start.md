# Extra Image Field Classes — agent index

One image field formatter that extends core's Image formatter and adds a text setting for extra
CSS classes applied to the rendered `<img>`. No global config, no permissions, no schema.

- **The formatter, its setting, and how classes are applied** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `extra_image_field_classes` (field type `image`), extends
  `\Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter`.
- Setting `extra_image_field_classes` (space-separated class names), default `''`.
- Classes appended to `#item_attributes['class']` in `viewElements()`.
- Depends on core `image`; use Field UI's *Manage Display* to select and configure it.
