<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Required Message (required_message) — agent index

**Lets site builders set a custom required-field validation message per field via a third-party setting, applied through the widget's `#required_error`.**

- **Version:** 8.x-1.x (8.x-1.1)
- **Core:** ^9.2 || ^10 || ^11
- **Dependencies:** drupal:field

## Surface
- No routes, permissions, services or config entities.
- `required_message_form_field_config_edit_form_alter()` — adds the "Required message" field to the Field UI edit form (visible only when Required is checked); saves it as third-party setting `required_message.required_error`.
- `required_message_field_widget_single_element_form_alter()` — applies the stored message to `$element['#required_error']`.

**Security:** no request-facing surface; the only configuration point is the core Field UI edit form, which already requires `administer <entity> fields`. No security findings.
