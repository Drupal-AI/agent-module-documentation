# Decorative Image Widget — agent index

Adds an opt-in **"Decorative" checkbox** to core Image field widgets so an editor must enter
alt text OR mark the image decorative (empty `alt=""`). No settings form, no configure route,
no plugins, no Drush, no permissions. Its only persistent state is a **third-party setting**
on an image widget in an `entity_form_display` config entity. Depends on core `image`.

- **Turn it on for an image field, the prerequisite (alt enabled, not required), where the
  setting is stored, the checkbox + validation behavior** →
  [configure/decorative-checkbox.md](configure/decorative-checkbox.md)

Key fact: the setting lives at
`core.entity_form_display.<entity>.<bundle>.<form_mode>` →
`content.<field>.third_party_settings.decorative_image_widget.use_decorative_checkbox: true`,
and the widget option only appears when the field's `alt_field_required` is **FALSE** (and
`alt_field` enabled).
