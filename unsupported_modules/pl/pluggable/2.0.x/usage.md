<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pluggable provides "pluggable plugin fields" — a field-type framework where a plugin type's available options become the allowed values of a field.

---

The module exposes a `pluggable_item` field type whose derivatives are backed by plugins, plus `pluggable_select` and `pluggable_radios` widgets and a `pluggable_default` formatter. Because core does not automatically expose derivative field types to widgets/formatters, the `.module` file implements `hook_field_widget_info_alter()` and `hook_field_formatter_info_alter()` to register every `pluggable_item` derivative against those widgets and the default formatter.

It is aimed at developers who want a field whose selectable values are defined and extended via the plugin system rather than a static allowed-values list — for example letting other modules contribute options to a field by adding plugins. There are no routes or permissions; the module is purely a set of field/plugin building blocks, so access is governed by the host entity's field access. Typical use: define a plugin-backed `pluggable_item` derivative, add it as a field, and choose the select or radios widget.

---
- Build a field whose options come from plugins
- Let other modules add field options via plugins
- Use a select widget for plugin-backed values
- Use radio buttons for plugin-backed values
- Expose derivative field types to widgets automatically
- Render plugin-backed field values with the default formatter
- Replace static allowed-values lists with extensible plugins
- Create developer-defined selectable field types
- Add options to a field without editing field config
- Provide a plugin-driven taxonomy-like selector
- Reuse a plugin type as a content field
- Extend field options at runtime through code
- Keep option lists in sync with registered plugins
- Prototype configurable field choices for a module
- Register derivative field types with widgets automatically
- Register derivative field types with the default formatter
- Contribute field options from a separate module
- Model a controlled vocabulary via plugin definitions
