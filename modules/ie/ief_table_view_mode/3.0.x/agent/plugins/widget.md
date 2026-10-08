<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget plugin: `inline_entity_form_complex_table_view_mode`

Class `Drupal\ief_table_view_mode\Plugin\Field\FieldWidget\InlineEntityFormComplexTableViewMode`
extends IEF's `InlineEntityFormComplex`.

```php
@FieldWidget(
  id = "inline_entity_form_complex_table_view_mode",
  label = "Inline entity form - Complex - Table View Mode",
  field_types = { "entity_reference", "entity_reference_revisions" },
  multiple_values = true
)
```

- `isApplicable()` returns TRUE only when the field's `target_type` has the entity handler
  `inline_form_table_view_mode` — which the module registers on **every** content entity type via
  `hook_entity_type_build()`. So the widget option shows for entity_reference /
  entity_reference_revisions fields targeting content entities.
- `createInlineFormHandler()` uses the `inline_form_table_view_mode` handler
  (`Drupal\ief_table_view_mode\Form\EntityInlineTableViewModeForm`, extends IEF `EntityInlineForm`).

## How columns are computed

`EntityInlineTableViewModeForm::getTableFields()` (the handler) builds the IEF table columns from
the referenced bundle's **`ief_table` view mode display** (`EntityViewDisplay` id
`<entity_type>.<bundle>.ief_table`), when that display exists and is enabled:

- Each display-configurable field with a component in the `ief_table` display becomes a column
  (`type => field`, using its label and weight).
- IEF's own default table fields are merged back in (keyed by the display weights).
- Extra fields (`getExtraFields()['display']`) present in the display become `callback` columns
  rendered via `ief_table_view_mode_table_field_extra_field_callback()` (which renders the entity
  in the `ief_table` view mode and returns that field's build).

If no enabled `ief_table` display exists for the bundle, it falls back to IEF's default columns.

## Config schema

`field.widget.settings.inline_entity_form_complex_table_view_mode` extends
`field.widget.settings.inline_entity_form_complex` — i.e. it accepts the same widget settings as
IEF Complex (allowed bundles, form mode, override labels, etc.).
