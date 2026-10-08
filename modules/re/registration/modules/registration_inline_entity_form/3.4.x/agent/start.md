<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Inline Entity Form — agent index

Lets a host's registration settings be edited **inline on the host edit form** via an Inline Entity
Form widget. Glue between Registration and the contrib `inline_entity_form` module. No configure
route.

- **The `inline_entity_form_settings` widget, its settings & the permission** →
  [configure/ief-widget.md](configure/ief-widget.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- Field widget id **`inline_entity_form_settings`** (for the `registration` field type); set it on the
  host bundle's registration field in Manage form display.
- Widget settings: `form_mode`, `override_labels`, `label_singular`, `label_plural`, `collapsible`,
  `collapsed`, `revision`, `hide_register_tab`.
- Permission `edit registration settings`.
