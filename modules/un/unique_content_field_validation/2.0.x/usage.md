<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unique Content Field Validation lets you mark a field, a content type's node title, or a taxonomy vocabulary's term name as **unique**, so Drupal rejects a second entity in the same bundle with a duplicate value — with an optional custom error message.

---

The module adds "Unique" settings to three existing forms via `hook_form_FORM_ID_alter()`, storing choices as **third-party settings** (no config of its own beyond schema). On the field settings form (`field_config_edit_form`) it adds a "Unique" checkbox + message textarea for supported field types (email, link, decimal, float, integer, list_*, entity_reference, text*, string*, webform); for multi-value fields it also adds "Do not allow same value" (uniqueness *within* the one field). On the node-type form it adds a "Unique" checkbox for the **title**, and on the vocabulary form for the term **name**. Enforcement happens two ways: (1) field-level uniqueness is validated by an `#element_validate` callback added in `hook_field_widget_single_element_form_alter()` that runs an `entityQuery` (matching value + bundle + langcode, excluding the current entity) and sets a form error if a match exists; (2) title/name uniqueness is a Symfony validation **constraint** `UniqueContentTitle`, added to every node `title` and taxonomy_term `name` base field via `hook_entity_base_field_info_alter()` / `hook_entity_bundle_field_info_alter()`, whose validator only fires when the node type / vocabulary has `unique = true`. Custom messages support `%label` (field/title label) and `%value` (the duplicate value) tokens. There is no admin settings page, permission, or Drush — you configure it inline on each field/bundle.

---

- Require that every Article title on a site is unique.
- Require unique term names within a specific taxonomy vocabulary.
- Make an email field unique so no two users/nodes share the same address.
- Enforce a unique "SKU" or "product code" string field per content type.
- Prevent duplicate entity-reference selections across entities of a bundle.
- Stop the same value being entered twice within one multi-value field ("Do not allow same value").
- Provide a friendly custom error message using `%label` and `%value` tokens.
- Keep slugs / external IDs stored in a text field unique per bundle.
- Ensure a "serial number" integer field never repeats within a content type.
- De-duplicate link fields so the same URL cannot be saved on two nodes of a type.
- Validate uniqueness on taxonomy term names for a controlled vocabulary (e.g. tags).
- Enforce unique titles on a "Landing page" type to avoid confusing duplicates.
- Add uniqueness to a webform field value.
- Give editors an immediate form error on save instead of a later data-cleanup task.
- Constrain a decimal/float measurement field to unique values per bundle.
- Prevent duplicate list_string / list_integer selections across entities.
- Turn uniqueness on per bundle without writing a custom constraint plugin.
- Keep uniqueness scoped per language (validation matches on langcode).
- Exclude the current entity when editing so re-saving an unchanged entity is allowed.
- Ship the uniqueness settings via configuration management (third_party_settings in field/node.type/vocabulary config).
- Show which field caused a conflict by echoing the duplicate value back in the message.
