<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Popup Field Group — agent index

Adds one Field Group formatter, id **`popup`** ("Popup"), that renders a group's children
hidden and opens them in a jQuery-UI dialog via an "Open popup" link. Supported contexts:
`form` and `view`. Depends on `field_group`. No settings page, permission, entity, or Drush.

- **Add a popup group, config storage, and every popup setting** →
  [configure/popup-group.md](configure/popup-group.md)

Key facts:
- The group is stored in the display config entity at
  `third_party_settings.field_group.<group_name>` with `format_type: popup` and a
  `format_settings` map (`popup_link`, `popup_labels`, `popup_settings`, `extra_css`).
- Trigger markup: `<a class="popup-field-group-open-popup" data-target="<group_id>">`.
- Library `popup_field_group/core` (deps `core/once`, `core/drupal.dialog`) drives the dialog.
- `extra_css` only appears when the System Stream Wrapper module is installed.
