<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read-only Field Widget — agent index

Provides one Field Widget plugin, `readonly_field_widget`. Assign it to a field on an
entity's form display and, instead of an editable input, the field's chosen **formatter**
renders as read-only markup on the edit form. Works on (nearly) any field type. No
configure route, no permissions, no Drush, no plugin types of its own — its only
persistent state is the widget's `settings` on an `entity_form_display` component.

- **Switch a field's widget to read-only, pick which formatter renders it, and read/write
  the setting via drush** → [configure/readonly-widget.md](configure/readonly-widget.md)

Key fact: the setting lives at
`core.entity_form_display.<entity>.<bundle>.<form_mode>` →
`content.<field>.type: readonly_field_widget` with
`content.<field>.settings: {label, formatter_type, formatter_settings, show_description, error_validation}`,
validated by the `field.widget.settings.readonly_field_widget` config schema.
