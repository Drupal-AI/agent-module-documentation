<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hide Revision Field — agent index

Hides the core "Revision log message" field on revisionable entity add/edit forms, per
entity type + bundle, by permission, or per user. It does this with one custom field
widget (`hide_revision_field_log_widget`) auto-assigned to the `revision_log` base field,
so all state lives in the standard `core.entity_form_display.{entity_type}.{bundle}.default`
config entity — there is **no dedicated settings form** (`configure` route is `null`).

- **Hide/show the field per bundle; widget settings keys (`show`, `hide_revision`, `default`, `permission_based`, `allow_user_settings`)** → [configure/form-display.md](configure/form-display.md)
- **The two permissions and per-user personalization** → [permissions/permissions.md](permissions/permissions.md)
- **How it works internally (hooks, the widget, the user `revision_log_settings` field)** → [api/mechanism.md](api/mechanism.md)
