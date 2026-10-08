<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Validation — agent index

Adds three **cross-element** validation rules to Webform elements. **No admin page, no
config schema, no permissions, no Drush, no plugin types, no `configure` route.** All state
is element properties stored in the `elements` YAML of a `webform.webform.<id>` config entity.

- **The three validators, their element property keys, supported types, UI location** →
  [configure/validators.md](configure/validators.md)
- **How validation is wired (hooks, `#validate`, the constraint class), extend it** →
  [api/custom-validation.md](api/custom-validation.md)

Key facts:
- Configured per element under *Edit element → "Form extra validation"* fieldset.
- Property keys: `#equal__enabled` + `#equal__components`; `#compare__enabled` +
  `#compare__component` + `#compare__operator` (`>` `>=` `<` `<=`) + `#compare__custom_error`;
  `#some_of_several__enabled` + `#some_of_several__components` + `#some_of_several__completed`
  + `#some_of_several__final_validation`.
- Supported types (`WebformValidateConstraint::ALLOWED_TYPES`): date, datetime, email, hidden,
  number, select, tel, textarea, textfield, webform_document_file, webform_entity_checkboxes,
  webform_signature, webform_time. Compare is limited to `ALLOWED_TYPES_COMPARE`: date,
  datetime, number, webform_time.
