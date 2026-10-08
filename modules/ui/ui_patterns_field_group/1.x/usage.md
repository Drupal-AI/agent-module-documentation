<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns Field Group connects the UI Patterns component system to Field Group, so a group of fields can render through a UI Patterns pattern instead of a plain wrapper. On the 1.x line it ships as a submodule of the `ui_patterns` project.

---

Field Group organises fields into groups (tabs, fieldsets, accordions) on entity view displays; UI Patterns provides reusable, theme-declared components (patterns). This integration adds a "Pattern" field-group formatter (`pattern_formatter`): choose a pattern and an optional variant for a group, then map each child field, nested group, or the group label to a slot of that pattern. It also registers a `fieldgroup` UI Patterns source so any pattern can consume a field group's rendered output. Everything is configured per view display in Manage display and exports with that display's config; nesting is supported, and the module recursively renders inner pattern groups. It is a theme-layer integration with no routes, permissions, services, or drush commands of its own — the grouped fields keep their normal access, rendered through a component at the theme layer.

Because 1.x is part of `ui_patterns` (install with `composer require drupal/ui_patterns`, enable `ui_patterns_field_group`), it targets UI Patterns 1.x; the standalone project's 2.0.x line targets UI Patterns 2.x and is a separate release. The module depends on both `field_group` and `ui_patterns` and is only useful when both are present, plus a theme or module that declares the patterns you map to.

---
- Render a field group as a UI Patterns pattern/component.
- Set a field group's formatter to "Pattern" on a view display.
- Map field-group children to a pattern's slots.
- Map the field-group label into a pattern slot (`_label` source).
- Choose a pattern variant for a rendered group.
- Nest pattern groups inside pattern groups (recursive rendering).
- Render a group as a card, accordion, or media-object component.
- Expose field groups as UI Patterns sources for other patterns.
- Limit which groups a pattern offers via the source `limit` context.
- Keep the pattern-to-group mapping in exported display config.
- Move a group's pattern mapping between environments via config sync.
- Add per-group Twig overrides using the generated template suggestions.
- Override a group's pattern per entity type, bundle, or view mode.
- Override a single pattern slot with destination-suggestion templates.
- Pass the displayed entity into pattern context automatically.
- Standardise repeated field groups on a shared design-system component.
- Reuse one pattern across many bundles' field groups.
- Theme grouped fields consistently through a component library.
- Bridge Field Group and UI Patterns 1.x without custom code.
- Configure pattern rendering only after adding fields and saving the display.
- Confirm both `field_group` and `ui_patterns` are enabled before use.
