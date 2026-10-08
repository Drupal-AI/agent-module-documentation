<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Require on Publish — agent index

Marks a field as **required only when its entity is published**. Editors can save empty drafts;
publishing is blocked until the field is filled. No settings page (`configure: null`), no
permission, no service, no Drush. Works on any entity type implementing
`EntityPublishedInterface` (e.g. node).

- **Enable it on a field; where the setting is stored; the two checkboxes** →
  [configure/field-setting.md](configure/field-setting.md)
- **How enforcement works: the `require_on_publish` constraint + validator** →
  [api/validation.md](api/validation.md)

Key facts:
- Enabled per field via a **third-party setting** on the `FieldConfig`:
  `require_on_publish.require_on_publish = true` (optionally `warn_on_empty = true`).
  Config object: `field.field.<entity>.<bundle>.<field>` → `third_party_settings.require_on_publish`.
- A validation constraint id `require_on_publish` is added to all publishable entity types; it
  blocks saving a **published** entity whose flagged field is empty.
- `warn_on_empty` shows a non-blocking warning when the entity is **unpublished** and the field
  is empty (only meaningful alongside `require_on_publish`).
