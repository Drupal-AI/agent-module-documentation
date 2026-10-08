<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Field Formatters — agent index

Part of **ui_patterns**. Renders fields through SDC components.

- Two formatters: `ui_patterns_component` (whole field → 1 component) and
  `ui_patterns_component_per_item` (each item → a component). Both apply to **all** field
  types (widened via `hook_field_formatter_info_alter`).
- Config lives in `core.entity_view_display.*` under the field's `settings.ui_patterns`.
- How to configure props/slots/sources: [configure/formatter.md](configure/formatter.md)
- Full `ui_patterns` settings shape + Source ids: see the parent module's
  `agent/configure/components.md`.
