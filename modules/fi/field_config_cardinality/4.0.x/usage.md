<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Config Cardinality lets you override a field's cardinality per field instance (per bundle), so one shared field storage can be single-value on one content type and multi-value on another.

---

In Drupal, cardinality (the allowed number of values) is a property of the **field storage**, shared by every bundle that uses the field — core exposes no per-instance override. This module adds an **"Allowed number of values (Cardinality Instance)"** fieldset to the field instance edit form (`field_config_edit_form`) and stores the chosen limit as the third-party setting `field_config_cardinality.cardinality_config` on that instance's `FieldConfig` (`field.field.<entity>.<bundle>.<field>`). An entity-builder (`field_config_cardinality_form_builder`) saves it; the instance limit may only be **lower than or equal to** the storage cardinality (unlimited storage allows any per-instance limit). At form-render time the module enforces the instance limit by swapping several core widget classes (`media_library_widget` → `CardinalityMediaLibraryWidget`, `image_image` → `CardinalityImageWidget`, `entity_reference_autocomplete` → `CardinalityEntityReferenceAutocompleteWidget`), providing extra cardinality-aware widgets (`cardinality_email_default`, `cardinality_options_select`, and `cardinality_ief_simple` when Inline Entity Form is present), and altering the multi-value form (`hook_field_widget_complete_form_alter`, `hook_preprocess_field_multiple_value_form`, `hook_field_widget_single_element_form_alter`) to cap the number of value rows, drop the extra "Add more" button, hide over-limit `managed_file` deltas, and turn a single-value `checkboxes` element into `radios`. It also supports optional custom "empty label" text per cardinality/required combination. No settings page, permission, or Drush command.

---

- Reuse one field storage as multi-value on Articles but single-value on Pages.
- Reduce the number of per-field database tables by sharing a storage across bundles.
- Limit a shared "tags" field to 3 values on one content type and unlimited on another.
- Constrain an image field to a single upload on one bundle while allowing many on another.
- Cap a media-library field to N items per bundle without new storage.
- Make an options (select/checkboxes) field single-value on one bundle (renders as radios).
- Override an entity-reference autocomplete field to allow only 2 references on a bundle.
- Set a per-instance limit lower than the shared storage's unlimited cardinality.
- Keep data for single- and multi-value instances of the same field in one table.
- Enforce the instance limit in the edit form (caps rows, removes extra "Add more").
- Provide a cardinality-aware email widget (`cardinality_email_default`).
- Provide a cardinality-aware Inline Entity Form (simple) widget with `inline_entity_form`.
- Configure custom "empty label" text for unlimited-not-required fields.
- Configure custom "empty label" text for limited-not-required fields.
- Configure custom "empty label" text for limited-required fields.
- Deploy per-instance cardinality via config by exporting the field's `FieldConfig`.
- Script the override with `setThirdPartySetting('field_config_cardinality', 'cardinality_config', …)`.
- Read a field instance's effective limit from its third-party settings.
- Avoid creating duplicate fields just to vary cardinality between bundles.
- Standardize a design system where the same field appears with different limits.
- Hide over-limit file inputs on a `managed_file` multi-upload widget per bundle.
- Turn a checkbox list into a radio list when an instance is limited to one value.
- Migrate a site toward shared field storages with per-bundle cardinality.
