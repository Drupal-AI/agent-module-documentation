<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Field Autocomplete Filter (entity_reference_field_autocomplete_filter) — agent index

One **field widget** for `entity_reference` fields that adds a **"Search within" bundle select**
to the core autocomplete, restricting suggestions to a single one of the field's allowed target
bundles. Extends core `EntityReferenceAutocompleteWidget`. Package `Custom`. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.5. **No dependencies, no permissions, no
config form, no routes** — reuses core's entity autocomplete + selection handling.

- **The widget, its settings, the bundle-select/AJAX flow, and how to enable it** →
  [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `EntityReferenceFilterableAutocompleteWidget` (id
  **`entity_reference_filterable_autocomplete`**, label *"Filterable Autocomplete"*), in
  `src/Plugin/Field/FieldWidget/EntityReferenceFilterableAutocompleteWidget.php`,
  `field_types = { "entity_reference" }`. Extends core
  `EntityReferenceAutocompleteWidget` (inherits all core autocomplete settings).
- Selected per view-form display on **Manage form display**. No field type, no formatter, no
  hooks (`.module` is an empty stub), no `.install`, no `.services.yml`, no `.routing.yml`,
  no `.permissions.yml`.
- Config schema: `field.widget.settings.entity_reference_filterable_autocomplete` (in
  `config/schema/`) mirrors core's widget settings — `match_operator`, `match_limit`, `size`,
  `placeholder`. No settings of its own beyond the inherited ones.
- One CSS library `entity_reference_field_autocomplete_filter/theme`
  (`css/entity-reference-field-autocomplete-filter.css`), a flex row for the select + textfield.

## Mechanism (from source)

- `formElement()` calls `parent::formElement()`, then reads the field's allowed bundles from
  `getFieldSetting('handler_settings')['target_bundles']` and builds bundle options via
  `bundleOptions()` (`entity_type.bundle.info` service, injected).
- **If ≤ 1 bundle option, it returns the plain core element** (no extra select).
- Otherwise it adds `$element['bundle']` (a `select` with `- Any bundle -` empty option, an
  AJAX callback, default = the referenced entity's current bundle) and sets
  `$element['target_id']['#selection_settings']['target_bundles']` to `[$selectedBundle]` when a
  bundle is chosen, else to the field's full allowed-bundles list.
- `getSelectedBundleFromFormState()` reads the chosen bundle from user input via
  `NestedArray::getValue()` (parents = field_parents + [fieldName, delta, 'bundle']).
- Static AJAX callback `updateTargetBundles()` returns the rebuilt `target_id` element (swaps
  `'bundle'` → `'target_id'` in the triggering element's `#array_parents`) so suggestions refresh.
- Autocomplete requests still go to **core's** `system.entity_autocomplete` endpoint and core
  selection handler (access-checked); this widget only sets the target-bundle scope.
