<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Required Message lets you set a custom "this field is required" error message per field, replacing Drupal's generic default.

---

The module is a small pair of form-alter hooks. `hook_form_field_config_edit_form_alter()` adds a "Required message" details section to the Field UI edit form (shown via `#states` only when the field is marked required), storing the entered text as a third-party setting under the `required_message` provider on the field config entity. At form render time, `hook_field_widget_single_element_form_alter()` reads that third-party setting and, when present, assigns it to the widget's `#required_error` property so Drupal's Form API emits the custom message instead of the default when the field is submitted empty.

It has no routes, permissions, services or config of its own beyond the third-party setting, and no request-facing surface — configuration happens entirely on the existing, access-controlled Field UI. Set-up: enable the module, edit a required field under Manage fields, and type the desired message in the "Required message" box.

---

- Set a friendly required-field error message on a specific field.
- Replace Drupal's generic "X field is required" text for a field.
- Add per-field guidance (e.g. "Please enter your email address") on empty submit.
- Configure the message on the Field UI field-edit form.
- Store the message as the `required_message.required_error` third-party setting.
- Show the message box only when the field is marked Required (via `#states`).
- Leave the message empty to fall back to the Drupal default.
- Improve form UX on contact, registration or content-entry forms.
- Apply custom messages to node, user, taxonomy or any fieldable entity's fields.
- Keep the setting in exported field config for deployment.
- Localize the message through standard config translation.
- Clarify validation for accessibility on required fields.
- Set distinct messages for multiple required fields on one form.
- Reduce user confusion on multi-field required forms.
- Remove a custom message by clearing the field and re-saving.