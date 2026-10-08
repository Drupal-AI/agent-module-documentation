# Media thumbnail URL formatter — agent index

One field formatter that prints a media entity's thumbnail image **URL** (not an `<img>`),
optionally via an image style and optionally absolute. Registered for `entity_reference`
fields; configured per field on **Manage display**. No config page (`configure` null), no
permissions, no Drush, no services. Depends on core `media`.

- **The `media_thumbnail_url` formatter, its two settings, where they're stored, and output
  behavior** → [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `media_thumbnail_url`, label "Thumbnail URL"; class
  `MediaThumbnailURLFormatter extends media MediaThumbnailFormatter`.
- Settings: inherited **Image style** (`image_style`) + added **Absolute URL** (`absolute`,
  bool). Parent's *Link image to* (`image_link`) is removed.
- Stored in `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.settings` (schema `field.formatter.settings.media_thumbnail_url`).
- Output per delta is a bare `#markup` URL string; media + image style added as cache deps.
