# Decorative Image — agent index

Adds a per-image **"decorative"** flag so presentation-only images render with `role="presentation"`
and empty `alt`, hidden from screen readers. Hook-driven, no config entity, no schema, no permissions,
no settings page (`configure` null). Requires core `image`.

- **Enable it on a field, the two field settings, per-image checkbox, and where state is stored** →
  [configure/field.md](configure/field.md)

Key facts:
- Two `FieldConfig` third-party settings under provider `decorative_images` (added to
  `field_config_edit_form` by `DecorativeConfigFormAlter`): `decorative_enabled`,
  `decorative_or_alternative_required`.
- Per-image checkbox `is_decorative` added to the image widget by `DecorativeWidgetFormAlter`
  (only when `decorative_enabled`); optional validator enforces "Alt or Decorative".
- Per-image flag is stored in **key-value** `decorative_images`, keyed by the file `target_id`
  (`hook_entity_presave`, only for `node` + `media` entities) — NOT on the field value.
- Display: `hook_preprocess_field` sets `#item_attributes['role']='presentation'` for flagged images;
  `hook_preprocess_image` then unsets `role` and sets `alt=''`.
- Only `image`-type fields are handled.
