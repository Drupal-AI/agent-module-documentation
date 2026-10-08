<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Responsive Thumbnail — agent index

Adds one field formatter, **`media_responsive_thumbnail`** ("Responsive thumbnail"), for
Media entity-reference fields. It extends core's `ResponsiveImageFormatter` and reuses its
settings, so a Media reference field can render through a `responsive_image_style` exactly
like a plain Image field does. No settings form of its own, no configure route
(`configure: null`), no permissions, no Drush, no plugin types defined. All persistent state
is the field's formatter settings inside an `entity_view_display` config entity.

- **Set the formatter on a Media reference field + its settings keys** →
  [configure/formatter.md](configure/formatter.md)
- **How it picks the image to render (source field vs thumbnail fallback) and its quirks** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the formatter only ever appears as an option on an `entity_reference` field whose
storage `target_type` is `media` (`isApplicable()`), and its settings live at
`core.entity_view_display.<entity>.<bundle>.<view_mode>` →
`content.<field>.type: media_responsive_thumbnail` /
`content.<field>.settings.{responsive_image_style,image_link,image_loading}`.
