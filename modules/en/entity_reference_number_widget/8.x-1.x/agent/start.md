<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Number Widget (entity_reference_number_widget) — agent index

A single **field widget** that edits a core `entity_reference` field as a plain **numeric input**:
the editor types the **target entity's ID** directly instead of using autocomplete or a select list.
Package `Fields`. **No dependencies** beyond Drupal core's Field API. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.2 (version-dir 8.x-1.x).

- **The widget, its form element, value handling, how to enable it** →
  [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `EntityReferenceNumberWidget` (id **`entity_reference_number`**, label *"Entity ID"*),
  in `src/Plugin/Field/FieldWidget/EntityReferenceNumberWidget.php`, extending core's `WidgetBase`.
  `field_types = { "entity_reference" }` — applies to **any core entity-reference field**.
- **No** field type, **no** formatter, **no** config objects, **no** config schema, **no**
  permissions, **no** routes, **no** services, **no** hooks, **no** Drush, **no** libraries.
  Just the widget class, `entity_reference_number_widget.info.yml`, `README.txt`, `LICENSE.txt`.

## Mechanism (from source)

- `formElement()` builds a `#type => 'number'` element with `#min => 0` and
  `#default_value` = the currently referenced entity's `id()` for that delta (else `NULL`), and
  returns it keyed as `['target_id' => $element]` (matching the entity-reference item's main
  property). No `#max`, no custom `#element_validate`.
- `massageFormValues()` iterates the submitted deltas and **unsets any whose `target_id` is empty**,
  so blank rows do not create references.
- Referenceability/validity of the entered ID is enforced by **core's** entity-reference field
  constraint, not by this widget; display access is handled by core's normal reference rendering.
