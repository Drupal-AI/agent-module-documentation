<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unique Content Field Validation — agent index

Marks a **field value**, a content type's **node title**, or a vocabulary's **term name** as
unique per bundle, rejecting duplicates on save. **No settings page, no configure route, no
permissions, no Drush.** Choices are stored as **third-party settings**; enforcement is via a
widget `#element_validate` callback (fields) and the `UniqueContentTitle` constraint (titles /
names).

- **Turn uniqueness on for a field / a node title / a term name, storage keys, messages** →
  [configure/uniqueness.md](configure/uniqueness.md)

Key facts:
- Field uniqueness → `field.field.<entity>.<bundle>.<field>` →
  `third_party_settings.unique_content_field_validation.unique: true` (+ `unique_text`, and
  `unique_multivalue` / `unique_multivalue_text` for multi-value fields).
- Node title uniqueness → `node.type.<bundle>` →
  `third_party_settings.unique_content_field_validation.unique: true` (+ `unique_text`).
- Term name uniqueness → `taxonomy.vocabulary.<vid>` → same key.
- The "Unique" field checkbox only appears for these field types: email, link, decimal,
  float, integer, list_float, list_integer, entity_reference, list_string, text, text_long,
  text_with_summary, string, string_long, webform.
- Messages support `%label` and `%value` tokens.
