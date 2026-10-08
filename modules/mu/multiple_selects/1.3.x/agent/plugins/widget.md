<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `multiple_options_select` widget (mechanism)

The whole module is one field widget plugin,
`Drupal\multiple_selects\Plugin\Field\FieldWidget\OptionsMultipleSelectWidget`, extending core's
`Drupal\Core\Field\Plugin\Field\FieldWidget\OptionsSelectWidget`. It defines no new plugin type
— it only supplies an instance of core's existing `field_widget` plugin type.

## Annotation

```php
/**
 * @FieldWidget(
 *   id = "multiple_options_select",
 *   label = @Translation("Multiple select list(s)"),
 *   field_types = {
 *     "entity_reference",
 *     "list_integer",
 *     "list_float",
 *     "list_string"
 *   },
 * )
 */
```

## What it overrides vs. `OptionsSelectWidget`

- **`form()`** — calls the parent (which builds the normal multi-value table: one row per
  delta, drag weights, "Add another item" button when cardinality allows) then attaches
  `validateMultipleElements` as an extra `#element_validate` callback on the whole widget
  element and copies `$this->column` onto `#column` for the validator to use later.
- **`formElement()`** — this is the core trick. The parent `OptionsSelectWidget::formElement()`
  normally builds ONE `<select multiple>` spanning all deltas (that's how core options widgets
  represent "multiple" — a single select box, not one box per row). This widget instead:
  1. Builds the parent element, then overwrites `#type` with the configured `element_type`
     (`select` or `select2`).
  2. Forces `#multiple = FALSE` — so each per-delta element is a single-value select, not a
     multi-select.
  3. Nests that single-select under `$element[$this->column]` (the field's main property, e.g.
     `target_id` for entity_reference) so field API's per-delta table structure ends up with
     one plain select per row.
  4. Sets the default value per row, using `_none` as the "no selection" placeholder for a
     plain select, or `''` for `select2` (`$option_element['#type'] === 'select2' ? '' : '_none'`)
     — Drupal core and the Select2 module disagree on what value means "nothing chosen".
  5. `unset($element['#type'])` — removes the parent's own top-level `#type` so the surrounding
     per-delta table rendering (from `WidgetBase`) takes over instead of a single combined select.

## Settings

```php
public static function defaultSettings() {
  return ['element_type' => 'select'] + parent::defaultSettings();
}
```

`settingsForm()` always offers `Select`; it offers `Select2` only if
`$this->moduleHandler->moduleExists('select2')`. `settingsSummary()` reports "Element: select"
or "Element: select2" on the Manage Form Display row.

## Required-field validation (`validateMultipleElements`)

A required multi-value field normally requires each individual sub-element to be non-empty.
This widget instead needs "at least one delta has a value" semantics (since editors may leave
extra rows blank). `validateMultipleElements()`:

1. Only runs when `$element['#required']` is TRUE.
2. Walks every integer-keyed child (each delta row). If ANY row's value (at
   `$element[$key][$element['#column']]['#value']`) is non-empty (per `isEmptyValue()`), it
   returns immediately — validation passes.
3. Otherwise it collects each row's drag `_weight` value, sorts ascending, and raises the
   "@name field is required." form error on the **first delta by weight** (not necessarily
   delta 0) — so the error lands on whichever row the editor sees first after reordering.

## Empty-value normalization (`validateElement`)

A per-row `#element_validate` (`validateElement`) clears the form value to `NULL` whenever
`isEmptyValue()` is true, so a row left on the placeholder doesn't get saved as the literal
string `_none` or an empty string.

```php
private static function isEmptyValue($value) {
  return $value === '_none' || $value === '';
}
```

## Consequences an agent should know

- Works with cardinality > 1 (fixed count or unlimited, `-1`); on cardinality 1 it behaves like
  an ordinary single select with no "Add another item" button.
- Selecting `select2` as the element type without the `select2` module installed will fail at
  render time — `settingsForm()` only lists `select2` as an option once the module is enabled,
  but nothing stops a raw config write from setting `element_type: select2` regardless, so keep
  the module dependency in mind when writing config directly.
- No custom validation constraint, formatter, or field type is added — this module changes
  only the **edit widget**; storage and display are untouched.
- `multiple_selects_post_update_add_element_type_to_widgets()` (in `multiple_selects.post_update.php`)
  backfills `element_type: select` onto pre-existing components on module update, using
  `ConfigEntityUpdater` over every `entity_form_display`.
