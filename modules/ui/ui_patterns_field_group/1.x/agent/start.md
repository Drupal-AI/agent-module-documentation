<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Field Group (ui_patterns_field_group) — agent index

Bridges **Field Group** and **UI Patterns 1.x**. Adds a field-group formatter that renders a field
group through a UI Patterns pattern (component), mapping the group's child fields to the pattern's
slots. Also exposes each field group (and its label) as a UI Patterns *source* so any pattern can
consume a group's output.

**Packaging (important):** on the 1.x line this is a **submodule of the `ui_patterns` project**
(`ui_patterns/modules/ui_patterns_field_group`, shipped inside `ui_patterns 8.x-1.15`). Install it
with `composer require drupal/ui_patterns`, then `drush en ui_patterns_field_group`. There is **no
standalone `drupal/ui_patterns_field_group` 1.x release** — the standalone project starts at 2.0.x.

- Dependencies: `field_group:field_group`, `ui_patterns:ui_patterns`. Core `^9 || ^10 || ^11`. Package `User interface`.
- No settings route, no permissions, no services file, no drush commands. All config lives per field
  group in **Manage display** (entity view display third-party settings). Ships one config schema.

Do:
- **Make a field group render as a pattern (config keys + YAML example)** → [configure/field_group_pattern.md](configure/field_group_pattern.md)
- **The `pattern_formatter` field-group formatter (class + runtime mapping flow)** → [plugins/pattern_formatter.md](plugins/pattern_formatter.md)
- **The `fieldgroup` UI Patterns source plugin** → [plugins/fieldgroup_source.md](plugins/fieldgroup_source.md)
- **Module hooks: form-alter submit fix + pattern template suggestions** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Field-group formatter plugin id `pattern_formatter` (class `PatternFormatter`, label "Pattern",
  `supported_contexts = {"view"}` — display only, not entity forms).
- UI Patterns source plugin id `fieldgroup` (class `FieldgroupSource`, `provider = "field_group"`,
  tag `entity_display`).
- Config schema `field_group.field_group_formatter_plugin.pattern_formatter` — keys `pattern`,
  `pattern_variant`, `pattern_mapping` (type `ui_patterns.pattern_mapping`), `show_empty_fields`.
- Settings stored under the group's `format_settings` in the view display
  `third_party_settings.field_group.<group_name>`.
- Utility `Drupal\ui_patterns_field_group\Utility\EntityFinder::findEntityFromFields()`.
- Injected services: `plugin.manager.ui_patterns`, `plugin.manager.ui_patterns_source`, `module_handler`.
