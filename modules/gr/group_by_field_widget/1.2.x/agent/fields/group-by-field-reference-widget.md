<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: `group_by_field_reference_widget`

The module's only surface. One `@FieldWidget` plugin that renders an
`entity_reference` field's options as **nested collapsible `details` groups**
instead of a flat list of checkboxes/radios. Grouping is driven by fields on the
*referenced* entities, followed along entity-reference paths.

- **Class:** `Drupal\group_by_field_widget\Plugin\Field\FieldWidget\GroupByFieldReferenceWidget`
- **Base:** `Drupal\Core\Field\Plugin\Field\FieldWidget\OptionsWidgetBase`
- **Plugin id / label:** `group_by_field_reference_widget` — "Group by field reference widget"
- **Applies to field type:** `entity_reference` only. Annotation `multiple_values = TRUE`.
- **Injected services:** `entity_field.manager`, `entity_type.manager`, `entity_type.bundle.info`.

## Where the options come from (access-respecting)

The list of selectable options is `$this->getOptions($items->getEntity())`
inherited from `OptionsWidgetBase` — i.e. the field's own options provider
(`EntityReferenceItem::getSettableOptions()`), which runs the field's configured
**selection handler**. The widget does **not** run its own entity query for the
choices, so the field's referenceable-entities / access filtering is preserved.
`formElement()` then `loadMultiple()`s only those option IDs (skipping `_none`)
to read their group-by field values.

## Widget settings

Stored under the form-display component's `settings`. `defaultSettings()`:
`bundle_options => []`, `group_by => ''`, `open_details => ''`.

| Setting | Type | Meaning |
| --- | --- | --- |
| `group_by` | array (up to 3 entries) | Ordered grouping levels. Each entry is a dot-delimited field path on the referenced entity, e.g. `field_facility` or `field_facility.field_campus` (follow entity-reference fields to nest). Rendered as 3 `select` elements in the settings form; level *n+1* is only shown/required once level *n* is chosen. |
| `bundle_options` | array (checkboxes) | **Only shown when the source field's `handler == "views"`.** Which target bundles to scan for groupable fields. Populates the `group_by` selects via an AJAX callback (`groupByAjaxCallback`). For non-Views handlers the groupable fields come from the field's own `handler_settings.target_bundles`. |
| `open_details` | boolean | Whether every generated `details` group renders `#open` by default. |

### Which fields are offered as group-by options

`getGroupOptions()` → `getFieldTree()` walks the target bundle's field
definitions (bundle-specific fields only: base fields are diffed out) and keeps a
field via `isGroupable()`, which requires **cardinality exactly 1** and a field
type in `['boolean', 'entity_reference']`. For an `entity_reference` field it
recurses into that field's `target_bundles`, building nested paths whose labels
join with ` => ` (e.g. `Facility => Campus`). This is why the "Group by" selector
is empty when the field has no single-cardinality boolean/reference fields, or
when a Views-handler field has no bundles selected yet.

> Note (from the module's own ROADMAP): `boolean` is advertised as groupable but
> the resolver only handles values with `target_id`, so boolean groups currently
> collapse into the "No Value" fallback group.

## Rendering: checkboxes vs radios

`formElement()` wraps everything in a top-level `details` (`#open => TRUE`) and
calls `groupFormElements()` per option. `parseGroupDetails()` follows the
`group_by` path on each option entity to resolve a group **key** (`$entity->id()`)
and **label** (`$entity->label()`); an unresolved path falls back to
`key => 'na', label => 'No Value'`. Groups are created as
`#type => details` keyed `group_<id>`.

The leaf option element (`addOptionElement()`):

- **Multi-value field** (`$this->multiple`) → `#type => checkbox` per option.
- **Single-value field** → `#type => radio`, `#return_value => option id`,
  `#parents => [field_name]` so all radios post to one input.
  - When the field is **optional**, each radio also gets class
    `group-by-field-widget-toggleable-radio` and the widget attaches library
    `group_by_field_widget/radio_toggle` — a small `core/once` behavior
    (`js/group-by-field-widget-radio-toggle.js`) that lets the user **clear** a
    selected radio by clicking it again.

Option labels (`$optionLabel`) and group labels (`$entity->label()`) are passed
as render-element `#title`, so they are escaped by the Form API / Twig — no raw
markup output.

## Submission (`massageFormValues`)

Reads raw `$form_state->getUserInput()` keyed by the field name.

- **Cardinality ≠ 1:** if the field key is absent → `[]`; otherwise
  `flattenFormValues()` flattens the nested checkbox tree and each truthy key
  becomes `['target_id' => $id]`.
- **Cardinality 1:** the single posted value; `NULL`, `''`, or `'_none'` →
  `[]`; otherwise `[['target_id' => $value]]`.

## Config schema

`config/schema/group_by_field_widget.schema.yml` defines
`field.widget.settings.group_by_field_reference_widget` with `bundle_options`
(`textfield`), `group_by` (`textfield`), `open_details` (`boolean`). Heads-up:
`bundle_options` and `group_by` actually hold **arrays** while the schema types
them as `textfield` (a known, documented mismatch — see the module ROADMAP).
There is also a stray duplicate `group_by_field_widget.schema.yml` at the module
root that Drupal does **not** load; edit the copy under `config/schema/`.

## How to enable it on a field

UI: *Manage form display* → set the entity-reference field's widget to
"Group by field reference widget" → configure the "Group by" level(s) →
save. Single-value fields become radios, multi-value fields become checkboxes.

Via config (form-display YAML), the component's `type` is
`group_by_field_reference_widget` and its `settings` carry `group_by`
(array of paths), `open_details`, and — for Views-handler fields —
`bundle_options`. Example PHP:

```php
$display = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'display', 'default');
$display->setComponent('field_facilities', [
  'type' => 'group_by_field_reference_widget',
  'settings' => [
    'group_by' => ['field_facility.field_campus', '', ''],
    'open_details' => TRUE,
    'bundle_options' => [],
  ],
])->save();
```
