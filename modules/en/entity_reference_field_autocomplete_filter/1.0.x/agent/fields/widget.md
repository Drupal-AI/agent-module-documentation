<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Filterable Autocomplete" entity-reference widget

## Install & enable

```bash
composer require drupal/entity_reference_field_autocomplete_filter
drush en entity_reference_field_autocomplete_filter -y
```

No dependencies beyond Drupal core (`core_version_requirement: ^10 || ^11`). No sub-modules, no
permissions of its own, no Drush commands, no configuration form, no install hooks.

## Enable it on a field

Plugin: `EntityReferenceFilterableAutocompleteWidget`, id **`entity_reference_filterable_autocomplete`**,
label *"Filterable Autocomplete"*, `field_types = { "entity_reference" }` (in
`src/Plugin/Field/FieldWidget/EntityReferenceFilterableAutocompleteWidget.php`). It applies to any
`entity_reference` field.

UI path: *Structure → (entity type) → (bundle) → Manage form display* → set your reference field's
widget to **Filterable Autocomplete** → gear icon for the (core-inherited) settings.

The "Search within" bundle select only appears when the reference field allows **two or more**
target bundles (configure them under the field's *Reference type → target bundles* setting). With
one or zero allowed bundles the widget renders as the plain core autocomplete.

## Settings

The widget adds **no new stored settings**. It inherits everything from core
`EntityReferenceAutocompleteWidget`, and `config/schema/entity_reference_field_autocomplete_filter.schema.yml`
declares the schema `field.widget.settings.entity_reference_filterable_autocomplete` for exactly
those core keys:

| Setting key | Meaning (inherited from core) |
|---|---|
| `match_operator` | Autocomplete matching: `STARTS_WITH` or `CONTAINS`. |
| `match_limit` | Maximum number of autocomplete suggestions. |
| `size` | Size of the textfield. |
| `placeholder` | Placeholder text for the textfield. |

## How the bundle filter is built (`formElement()`)

1. `$element = parent::formElement(...)` — start from the core autocomplete element.
2. `$referencedEntities = $items->referencedEntities()`; `$thisEntityBundle` = the bundle of the
   entity already referenced at this delta (used as the select's default).
3. `$enabledBundles = $this->getFieldSetting('handler_settings')['target_bundles']` — the field's
   configured allowed bundles.
4. `$bundleOptions = $this->bundleOptions($enabledBundles)` — builds `machine_name => label`
   options from the `entity_type.bundle.info` service (falls back to the machine name if no label;
   a `NULL` `$enabledBundles` means "all bundles of the target type").
5. **`if (count($bundleOptions) <= 1) return $element;`** — one/zero bundles → plain core widget.
6. `$selectedBundle = getSelectedBundleFromFormState(...)` — the user's current choice (or the
   fallback bundle). If set, `$element['target_id']['#selection_settings']['target_bundles'] =
   [$selectedBundle]`; otherwise it is set to the full `$enabledBundles` list.
7. Adds `$element['bundle']` — a `#type => 'select'` titled *"Search within"*, options =
   `$bundleOptions`, `#empty_option` = *"- Any bundle -"*, `#default_value` = `$thisEntityBundle`,
   `#weight => -1`, with an `#ajax` callback to `updateTargetBundles`.
8. Wraps the elements: the bundle select gets a `<div class="…-wrapper">` prefix, the `target_id`
   gets `<div id="{wrapperId}">` so AJAX can replace it (`wrapperId =
   Html::getClass($fieldName) . '-target-id-wrapper-' . $delta`).
9. Attaches the CSS library `entity_reference_field_autocomplete_filter/theme`.

## Reading the selected bundle (`getSelectedBundleFromFormState()`)

Builds the parents array from `$element['target_id']['#field_parents']` plus
`[$fieldName, $delta, 'bundle']`, then `NestedArray::getValue($form_state->getUserInput(),
$parents)`; returns that value or the `$fallback` (the referenced entity's bundle). This keeps the
selection correct for nested/multi-delta field structures.

## AJAX refresh (`updateTargetBundles()`)

Static callback. Takes the triggering element's `#array_parents`, replaces the last segment
(`'bundle'`) with `'target_id'`, and returns `NestedArray::getValue($form, $parents)` — i.e. the
rebuilt `target_id` autocomplete element (now carrying the new `#selection_settings['target_bundles']`),
which core replaces into the `#{wrapperId}` div. Result: changing the bundle immediately re-scopes
the suggestions.

## Notes

- The actual autocomplete query and access filtering are core's: suggestions come from
  `system.entity_autocomplete` and the field's entity-reference selection handler. This widget only
  narrows the `target_bundles` passed to that handler — it never widens the target entity type and
  never bypasses core's selection access checks.
- On form submit, the referenced entity is still validated against the field's own configured
  handler settings by core; the widget's runtime bundle scope only affects which suggestions are
  offered, not what the field ultimately accepts.
- Dependency injection: the plugin overrides `create()`/`__construct()` to inject
  `entity_type.bundle.info` (`EntityTypeBundleInfoInterface $bundleInfo`).
