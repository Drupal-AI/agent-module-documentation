# Field plugins & integrations

This module does **not define a plugin type**; it adds Field API plugins (all subclassing core)
plus three third-party integration plugins. Reuse these classes when subclassing or theming.

## Field API plugins

| Kind | Plugin id | Class | Extends (core) |
|---|---|---|---|
| Field type | `entity_reference_override` | `Plugin\Field\FieldType\EntityReferenceOverride` | `EntityReferenceItem` |
| Widget | `entity_reference_override_autocomplete` (default) | `Plugin\Field\FieldWidget\EntityReferenceOverrideAutocomplete` | `EntityReferenceAutocompleteWidget` |
| Widget | `entity_reference_override_select` | `Plugin\Field\FieldWidget\EntityReferenceOverrideSelect` | `OptionsSelectWidget` (options) |
| Formatter | `entity_reference_override_label` (default) | `Plugin\Field\FieldFormatter\EntityReferenceOverrideLabelFormatter` | `EntityReferenceLabelFormatter` |
| Formatter | `entity_reference_override_entity` | `Plugin\Field\FieldFormatter\EntityReferenceOverrideEntityFormatter` | `EntityReferenceEntityFormatter` |

- The field type adds the `override` + `override_format` properties/columns in
  `propertyDefinitions()` / `schema()`, default settings `override_label` + `override_format`,
  and a `fieldSettingsForm()`. Its `getPreconfiguredOptions()` returns `[]` (it deliberately does
  **not** clutter the field-type list with per-target-type presets).
- Both widgets share **`OverrideTextWidgetTrait::overrideTextWidget()`**, which appends the
  `override` element (a `textfield`, or a `text_format` when `override_format` is set) and
  attaches the `entity_reference_override/form-fixes` library.
- Reuse `OverrideTextWidgetTrait` to add the override box to your own reference widget.

## Third-party integration plugins

- **Diff:** `Plugin\diff\Field\EntityReferenceOverrideFieldBuilder` — a field diff builder so
  override values show in revision comparisons (schema:
  `diff.plugin.settings.entity_reference_override_field_diff_builder`).
- **Feeds:** `Feeds\Target\EntityReferenceOverride` — a Feeds target mapping importable values
  onto the field.
- **Entity Usage:** `entity_reference_override_entity_usage_track_info_alter()` registers the
  field type with the core `entity_reference` usage tracker so referenced entities are counted.

## Module functions (in .module)

- `entity_reference_override_validate_custom_text($element, $form_state, $form)` — the
  `#element_validate` callback the widgets attach when `override_format` is set; flattens the
  `text_format` element's `{value, format}` into the `override` / `override_format` field values.
- `entity_reference_override_help()` — help text at `help.page.entity_reference_override`.

No hooks are *invited* by this module (no `.api.php`); there is no plugin manager to extend.
