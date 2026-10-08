<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `FieldPatchPlugin` plugin type (diff / merge per field type)

## The plugin type

- Annotation: `src/Annotation/FieldPatchPlugin.php` (`@FieldPatchPlugin`).
- Interface: `src/Plugin/FieldPatchPluginInterface.php`; base:
  `src/Plugin/FieldPatchPluginBase.php` (implements `ContainerFactoryPluginInterface`).
- Manager service: `plugin.manager.field_patch_plugin`
  (`src/Plugin/FieldPatchPluginManager.php`), discovery dir `Plugin/FieldPatchPlugin`,
  alter hook `change_requests_field_patch_plugin_info`, cache key
  `change_requests_field_patch_plugin_plugins`.
- Each plugin declares the core `fieldTypes` it handles and a `properties` map (each field
  property → `default_value` and a `patch_type` of `diff` or `data`).

Plugins shipped (`src/Plugin/FieldPatchPlugin/`): `FieldPatchText`, `FieldPatchTextSummary`,
`FieldPatchData` (numbers/email/telephone/etc.), `FieldPatchBoolean`, `FieldPatchList`,
`FieldPatchLink`, `FieldPatchDateTime`, `FieldPatchDaterange`, `FieldPatchReference`,
`FieldPatchFile`, `FieldPatchImage`.

## Manager API (`FieldPatchPluginManager`)

- `getPatchableFieldTypes()` — all field-type strings any plugin supports.
- `getPatchableFields($node_type_id, $bypass_explicit = FALSE)` — field definitions of a bundle
  minus: types with no plugin, `general_excluded_fields`, and (unless bypassed) the bundle's
  `bundle_<type>_fields` exclusions.
- `getPluginFromFieldType($field_type, $config = [])` — instance for a field type (direct id match,
  else searches each definition's `fieldTypes`); returns `FALSE` if none.
- `getDiff($field_type, $old, $new)` → plugin `getFieldDiff()`; `patchField($field_type, $value,
  $patch)` → plugin `patchFieldValue()`.

## Base class mechanics (`FieldPatchPluginBase`)

- `getFieldDiff($old, $new)` — iterates field deltas and properties; for each property calls a
  property-specific `getDiff<Property>()` if present else `getDiffDefault()`.
  `getDiffDefault()` returns `json_encode(['old'=>…, 'new'=>…])` (or `[]` when unchanged) — i.e.
  a plain replacement record. Text-family plugins override to store a diff-match-patch text patch.
- `patchFieldValue($value, $patch)` — applies each property patch via `applyPatch<Property>()` or
  `applyPatchDefault()`, returning `result` + per-item `feedback` (`code` 0–100, `applied` bool).
  `applyPatchDefault()` supports a `strict` mode that flags conflicts when the current value no
  longer matches the recorded `old`.
- `getFieldPatchView($values, $field, $label)` — builds the render array for the left "intended
  changes" column (`cr_field_patches` / `cr_field_patch` themes; optional `cr_diff_switch` toggle
  when the plugin `isUsingDiff()`).
- `validateDataIntegrity($value)` — write-guard used by the apply form: value must be an array
  containing all of the plugin's declared properties; otherwise the item is filtered out before
  the node is saved.
- `setWidgetFeedback()` / `setFeedbackClasses()` / `mergeFeedback()` — annotate the right-column
  widgets with merge success/conflict classes and messages.
- `methodName($prefix, $property)` — resolves optional per-property override methods
  (e.g. `patchFormatterValue`, `getFormattedValue`).

## `DiffService` (`change_requests.diff`, `src/DiffService.php`)

Adapter over `DiffMatchPatch\DiffMatchPatch`:

- `getTextDiff($src, $target)` → `patch_make()` + `patch_toText()` (stringified patch).
- `applyPatchText($value, $patch, $property)` → `patch_fromText()` + `patch_apply()`; computes an
  applied-percentage `code` and returns `result` + `feedback`; on failure keeps the original value.
- `patchView($patch, $value_old)` → applies the patch, runs `diff_main()` +
  `diff_prettyHtml()` and returns the highlighted diff as `#markup` (diff-match-patch escapes the
  text and wraps insertions/deletions in `<ins>`/`<del>`).

## Adding support for a custom field type

Create `src/Plugin/FieldPatchPlugin/FieldPatch<Name>.php` extending `FieldPatchPluginBase`, with
`@FieldPatchPlugin(id=…, fieldTypes={…}, properties={ <prop>: {default_value:…, patch_type:
"diff"|"data"} })`. Override `getDiff<Prop>()` / `applyPatch<Prop>()` / `patchFormatter<Prop>()`
only where the default replace/JSON behaviour is not enough (see `FieldPatchText` for the diff
case, `FieldPatchReference`/`FieldPatchImage` for structured `data` cases). Enable the field type
per bundle via the settings form (it appears once a plugin exists and the field is not excluded).
