<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Field - SDC display — agent index

Renders an entity **view mode** through a Single Directory Component (SDC), mapping Custom
Field column values to component **props** and other fields to **slots**. No field type,
widget, or settings page — configured per view mode as a **third-party setting on the
`entity_view_display`**.

- **Where the component binding is stored, its keys, and how to set it (UI + scriptable) plus
  the render mechanism** → [configure/sdc-display.md](configure/sdc-display.md)

Key facts:
- Third-party setting: `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `third_party_settings.custom_field_sdc.settings` = `{enabled: bool, component: <sdc id>,
  variant: string, props: sequence, slots: sequence}`.
- Config schema key: `core.entity_view_display.*.*.*.third_party.custom_field_sdc`.
- `hook_entity_view_alter()` (EntityHooks) replaces the built output with a
  `#type => component` element when `enabled` and a valid `component` are set; defers to the
  `sdc_display` module when that is enabled; skips/log on invalid components or missing
  required props.
- The Manage-display UI section is added by `hook_form_entity_view_display_edit_form_alter()`
  (FormHooks); saving unsets the third-party setting when disabled.
- Depends only on `custom_field` (SDC is Drupal core). The `component` value must be a real
  SDC plugin id (e.g. `navigation:badge`, `olivero:teaser`).
