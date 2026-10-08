<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `display_field_copy` DS field plugin

Display Field Copy does **not** define a new Drupal plugin *type*. It provides one
Display Suite field plugin (`DsField`) that is derived per configured copy.

- Plugin class: `Drupal\display_field_copy\Plugin\DsField\DisplayFieldCopy`
  (`@DsField(id = "display_field_copy", deriver = ...\Derivative\DisplayFieldCopy)`).
- Deriver: `Drupal\display_field_copy\Plugin\Derivative\DisplayFieldCopy` extends DS's
  `DynamicField` deriver; it scans `ds.field.*` config and emits one derivative for every
  object whose `type == 'display_field_copy'`, keyed `<entity_type>-<id>`.
- Add/edit form: `Drupal\display_field_copy\Form\DisplayFieldCopyForm` extends DS's
  `FieldFormBase` (const `TYPE = 'display_field_copy'`, type label `Copy field`); it hides
  DS's `entities` and `ui_limit` controls and adds the source-field select.

## Render mechanism

`DisplayFieldCopy::build()`:
1. Resolves the source field definition from `properties.field_id` (base field via
   `entity_field.manager`, or `field_config` storage for a 3-part id).
2. Reads the live items off the current entity: `$this->entity()->get($this->getRenderKey())`
   where `getRenderKey()` is the last dot-segment of `field_id`.
3. Builds a formatter instance for that field type via `plugin.manager.field.formatter`,
   using the formatter `type` chosen in *Manage display*, and returns
   `$formatter->viewElements($items, $langcode)`.

`formatters()` returns the formatter options for the source field's type, so the copy can
use any formatter the original field could.

## Theme unwrapping

`display_field_copy_field()` (a preprocess added to `field` and every `base hook == field`
theme hook by `hook_theme_registry_alter()`) detects `#field_type == 'ds'` fields whose
`#field_name` begins `display_field_copy:` and flattens the nested render items into the
top-level element (setting `#is_multiple` when there are several), so the copy's markup
matches a normal field render.

No hooks are invited, no services are exposed for reuse — to add copies, write `ds.field.*`
config (see [../configure/field-copy.md](../configure/field-copy.md)); to change rendering,
pick a different formatter on the copy in *Manage display*.
