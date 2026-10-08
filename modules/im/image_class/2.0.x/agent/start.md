# Image Class — agent index

Adds a **Class** textfield to the `image`, `responsive_image`, `media_thumbnail` and
`media_responsive_thumbnail` field **formatters**. The space-separated value is stored as a
third-party setting on the field's component in an `entity_view_display` config entity and applied
to the rendered `<img>` element. No settings form, no configure route (`configure: null`), no
plugins, no Drush, no permissions.

- **Turn it on for an image field, where the class is stored, which formatters, drush/config** →
  [configure/add-class.md](configure/add-class.md)

Key fact: the value lives at
`core.entity_view_display.<entity>.<bundle>.<view_mode>` →
`content.<field>.third_party_settings.image_class.class: "<space separated classes>"`, and
`hook_preprocess_field()` merges it into each item's `#item_attributes['class']`.
