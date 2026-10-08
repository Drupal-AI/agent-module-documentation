# Block ID — agent index

Adds a custom HTML `id` and CSS class fields (wrapper / title / content) to the core block config
form, stored as block third-party settings under the `block_id` namespace. One permission; no
settings page (`configure` null), no config schema, no Drush, no plugin types. Requires core `block`.

- **The four fields, third-party-setting keys, uniqueness validation, render mapping, permission** →
  [configure/block-settings.md](configure/block-settings.md)

Key facts:
- Permission **`administer block id`** gates both the form fields and rendering-time reads.
- Third-party settings (namespace `block_id`): `id`, `title_class`, `content_class`, `class_block`
  (all stored on the `block` config entity; empties unset in `hook_block_presave`).
- `hook_form_block_form_alter` adds the fields; a submit validator rejects a duplicate `id` used by
  another block.
- `hook_preprocess_block`: `id` → `attributes.id` (applied verbatim); each `*_class` string is
  `explode(' ')`-split and each part run through `Html::cleanCssIdentifier()` before being added to
  `attributes` / `title_attributes` / `content_attributes`.
