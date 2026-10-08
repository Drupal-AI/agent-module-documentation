<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Disable Field — agent index

Adds per-field **"Disable Field Settings"** to the field-config / base-field-override edit
forms, letting you disable a field's widget on the **add** and/or **edit** entity form,
optionally by role. State is stored as **third-party settings** on the field config entity
(`disable_field.add_disable`, `add_roles`, `edit_disable`, `edit_roles`). No configure route,
no Drush, no plugins. One service (`disable_field.config_form_builder`) builds the settings UI;
one hook applies `#disabled` at form build.

- **Turn disabling on for a field, the four modes, where it is stored, scripting it** →
  [configure/disable-field.md](configure/disable-field.md)
- **The `administer disable field settings` permission that gates the UI** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Values live on the **field's** config entity, e.g.
  `field.field.node.article.field_x` → `third_party_settings.disable_field.edit_disable: all`.
- Modes for each of add/edit: `none` | `all` | `roles` (disable for listed roles) |
  `roles_enable` (enable only for listed roles). Roles in `add_roles` / `edit_roles`.
- It sets `#disabled` on the widget (soft/UX lock), it is **not** a security access control.
