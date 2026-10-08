<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Patterns (entity_reference_patterns) — agent index

"Pathauto for autocomplete fields." Rewrites the labels shown in entity-reference **autocomplete
suggestions**, **existing/default field values**, and **select/checkbox/radio option lists** from the
bare `Label (id)` to a Token string configured per entity type + bundle. Presentation only — the
stored reference value is unchanged. Depends on contrib **`token`**. Core `^10.6 || ^11.3 || ^12`
(OO hooks). Configure route: `entity.entity_reference_pattern.collection`
(`/admin/config/search/entity-reference-patterns`). Defines 5 permissions, a config entity type, and a
config schema; no Drush commands, no plugin types.

- **Create/manage a pattern (config entity, form fields, PHP/drush, schema, matching + runtime
  mechanism)** → [configure/patterns.md](configure/patterns.md)
- **Who can manage patterns** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity `entity_reference_pattern`, `config_prefix: pattern` → config name
  **`entity_reference_patterns.pattern.<id>`**. Exported keys: `id`, `label`, `type` (target entity
  type), `pattern` (Token string), `selection_criteria` (`{bundles: {...}}`), `weight`; also
  `status`. Schema key `entity_reference_patterns.pattern.*`.
- Admin UI: draggable list `Controller\EntityReferencePatternListBuilder`; forms
  `Entity\Form\PatternEditForm` / `PatternDuplicateForm`; modal (AJAX) add/edit/duplicate/delete.
- Permissions: `administer entity reference pattern` (restricted), `add`/`edit`/`duplicate`, and
  `delete entity reference pattern` (restricted).
- Runtime services/hooks: route subscriber `entity_reference_patterns.route_subscriber` swaps the core
  `system.entity_autocomplete` controller for `Controller\EntityAutocompleteController` +
  `EntityReferencePatternMatcher` (`entity_reference_patterns.autocomplete_matcher`);
  `#[Hook('element_info_alter')]` repoints the autocomplete element `#value_callback` at
  `Element\EntityAutocomplete` (default-value labels); `#[Hook('options_list_alter')]` →
  `EntityReferencePatterns` (`entity_reference_patterns.module`) rewrites select-widget labels.
- Matching: `EntityReferencePatternEntity::loadByTargetType()` / `findMatchingPattern()` — enabled
  patterns sorted by `weight`, lightest matching bundle wins; tokens resolved with `['clear' => TRUE]`.
- JS `entity_reference_patterns.autocomplete` hides the trailing ` (id)` in the visible input.
