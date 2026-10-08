<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allowed Options (allowed_options) — agent index

**Limits which of a list/options field's allowed values appear, per form-display widget instance** — without altering the shared field storage.

- **Version:** 2.1.x
- **Core:** `^10 || ^11`  · package Fields · depends on core `field`
- **No routes, permissions or services.** Pure hook/widget module.
- **Hooks:** `hook_field_widget_third_party_settings_form()` (adds the **Allowed options** checkboxes); `hook_field_widget_single_element_form_alter()` (intersects `#options` to selected keys on non-default widgets); `allowed_options_entity_form_display_presave()` (normalizes keys — config storage disallows dots).

**Security:** no routes, endpoints or permissions; operates only inside form-display config and widget rendering. Purely presentational option filtering. No security findings.

See [configure/widget.md](configure/widget.md)
