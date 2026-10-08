# How the limit is enforced

Hook implementations live in `src/Hook/LimitedFieldWidgetsHooks.php` (OOP hooks) plus
procedural helpers in `limited_field_widgets.module`.

## 1. Offer the setting — `hook_field_widget_third_party_settings_form()`

Only when `$field_definition->getFieldStorageDefinition()->getCardinality() === CARDINALITY_UNLIMITED`.
Returns a required `limit_values` number element (`#min = 0`, default from the widget's
third-party setting). For `FieldConfigInterface` fields it also attaches a
`#value_callback` (`limited_field_widgets_save_limit_setting_callback`) that additionally
saves the value onto the `FieldConfig` third-party settings, and a `data-entity-id-target`
attribute carrying the field config id.

## 2. Enforce on save — `hook_entity_bundle_field_info_alter()` + `ItemCount` constraint

For every field with a numeric `limit_values > 0`, an `ItemCount` constraint is added:
`$field->addConstraint('ItemCount', ['max' => $limit])`. The validator
(`Plugin/Validation/Constraint/ItemCountConstraintValidator`) adds a violation
("Field contains too many values, up to %max allowed.") when `count($value) > max`
(a max of 0 is treated as "no limit"). This is the authoritative, storage-level guard — it
fires even for programmatic saves.

`ItemCount` is a validation constraint plugin defined by this module
(`#[Constraint(id: 'ItemCount', ...)]`).

## 3. Enforce in the UI — `hook_field_widget_complete_form_alter()`

When a limit is set (and the form isn't programmed) the widget form is rewritten so editors
cannot exceed it. Behavior by widget type:

- **limit == 1**: `checkboxes` → `radios`, `select` becomes single-value (`#multiple = FALSE`).
- Adds `#limit` and an `_limited_field_widgets_limit_validation` element validator to
  `select` / `checkboxes` / tags `entity_autocomplete`.
- **Multi-value "Add another" widgets** (`#max_delta`): hides `add_more` and trims extra
  deltas once the max is reached.
- **`media_library_widget`**: removes extra selected items and hides the "Add media" open button.
- **`inline_entity_form_complex`**: removes extra entities and hides the IEF add action.
- **`file_generic`**: trims extra file deltas.
- **`select2` / `select2_entity_reference`**: sets `#cardinality = $limit`.
- **Paragraphs** widgets: recomputes `#max_delta` manually to enforce the cap.

So the cap is enforced twice: the `ItemCount` constraint on validation, and the widget
alteration in the UI.
