<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# autocomplete_deluxe — agent index

One deliverable: a field widget with plugin id **`autocomplete_deluxe`** (label
"Autocomplete Deluxe"). It applies to **`entity_reference`** fields only, declares
`multiple_values = TRUE`, and renders a jQuery UI tag-box (chips) instead of core's plain
autocomplete. There is **no global admin settings form** (`configure` is null) — all
configuration lives on each field's *Manage form display* component
(`field.widget.settings.autocomplete_deluxe`). No permissions, no Drush commands, no plugin
types defined.

- **Apply & configure the widget** on a field's form display (settings keys, defaults,
  drush/PHP recipe) → [configure/widget.md](configure/widget.md)
- **The render element & plugin internals** (`autocomplete_deluxe` FormElement, autocomplete
  route, selection handlers, libraries) → [plugins/element.md](plugins/element.md)

Facts: widget id `autocomplete_deluxe`; field type `entity_reference`; config schema
`field.widget.settings.autocomplete_deluxe`; autocomplete route
`autocomplete_deluxe.autocomplete` (permission "access content"); render element
`autocomplete_deluxe`. Configure a field to use it by setting its `entity_form_display`
component's `type` to `autocomplete_deluxe`.
