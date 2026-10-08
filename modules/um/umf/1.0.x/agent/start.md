# Universal Media formatter — agent index

One field formatter (`universal_media`) for entity-reference→media fields that renders media
thumbnails through a responsive image style, straight from the referencing entity. Depends on
core `media` + `responsive_image`. No config page (`configure` null), no permissions, no schema,
no Drush, no custom plugin types.

- **Where to enable it, every formatter setting, and its render behavior (SVG / video / access / cache)** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `universal_media`, only applicable when the field's `target_type == media`
  (`isApplicable()`); extends core `ImageFormatterBase`.
- Renders media `thumbnail`: JPEG/PNG → `responsive_image_formatter`; SVG → `image_formatter`;
  generic video thumbnail → falls back to the media default view mode.
- Checks `view` access per media item; adds cache tags for the responsive image style, image
  styles and media entities.
