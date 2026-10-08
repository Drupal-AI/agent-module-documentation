<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Field Group (ui_patterns_field_group) — agent index

Bridge that lets a **field group** be rendered by a **UI Patterns 2.x component** (SDC). Adds a
field-group formatter (`component_formatter`) plus two UI Patterns *source* plugins that map a
group's children and label into a component's slots/props. Depends on `field_group` and
**`ui_patterns (>=2)`**. Core `^9 || ^10 || ^11`. Release **2.0.0-beta1 (beta)**.

No routes, no permissions, no services file, no global settings, no config schema of its own. All
configuration lives per field group in **Manage Display** (view display third-party settings).

Do:
- **Make a field group render as a component (config keys + YAML + how-to)** → [configure/field_group_component.md](configure/field_group_component.md)
- **The `component_formatter` field-group formatter (class + runtime flow)** → [plugins/component_formatter.md](plugins/component_formatter.md)
- **The two UI Patterns source plugins (`field_group_child`, `field_group_label`)** → [plugins/sources.md](plugins/sources.md)

Key facts:
- Formatter id `component_formatter` (class `ComponentFormatter`, label "Component",
  `supported_contexts = {"view"}` — view displays only, not entity forms).
- Component + variant + slot/prop values are configured in the **group edit form**, not the "add
  group" form (the add form only shows an "add fields and save first" notice).
- Settings stored under the group's `format_settings.ui_patterns`:
  `{component_id, variant_id, slots, props}` (from `getComponentFormDefault()`).
- Sources: `field_group_child` (`prop_types: [slot]`) maps a group child's render array into a slot;
  `field_group_label` (`prop_types: [slot, string]`) supplies the group label, escaped or
  `Xss::filterAdmin`-filtered when `label_as_html` is set.
- Injected into the formatter: `plugin.manager.sdc` (`ComponentPluginManager`) and
  `ui_patterns.chain_context_entity_resolver`. Utility: `Utility\EntityFinder::findEntityFromFields()`.
- Same shape as `ui_styles_paragraphs`: a thin connector between a design-system module and an
  editorial-structure module. It ships **no** components itself — an empty component list means the
  theme / a component module declares none.
- 1.x note: on the UI Patterns 1.x line this integration is a *submodule of `ui_patterns`*; the
  standalone `drupal/ui_patterns_field_group` project (and the `component_formatter` naming) begins
  at 2.0.x. The 1.x formatter id was `pattern_formatter` — the stale test fixtures still use it.
