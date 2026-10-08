<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render/form elements

The picker UI is a form element that extends core `Select`. Widgets and the CKEditor dialog forms all
render `#type => 'dsfr4drupal_picker_icon'` or `'dsfr4drupal_picker_pictogram'`; the FontIconPicker
JavaScript enhances the underlying select into the icon/pictogram picker.

## PickerBase (`src/Element/PickerBase.php`)

Abstract, extends core `Render\Element\Select`. Consts: `DATA_ATTRIBUTE_PREFIX =
'data-dsfr4drupal-picker-'`, `PICKER_ELEMENT` (set by subclass).

- `getInfo()` — prepends `processPicker` to `#process`, appends `preRenderPicker` to `#pre_render`,
  and sets defaults `#allowed_groups => []`, `#has_search => TRUE`, `#keep_open => FALSE`.
- `processPicker()` — builds `#options` from `picker->getItemsAvailable()` (skipping groups not in
  `#allowed_groups` when that is set). It deliberately **flattens** options with
  `array_combine($items, $items)` rather than using optgroups — the source comment notes this keeps
  core Select's flatten-and-validate behaviour, so a submitted value outside the built option set is
  rejected by core form validation. Also builds `drupalSettings['source_<element>']` grouped by
  translated group label, sets `#empty_value => ''`, and defaults a required field to the first
  option. A `\LogicException` (library missing) is caught and logged; options stay empty.
- `preRenderPicker()` — adds the element class, sets data attributes (`…-empty-icon`,
  `…-has-search`, `…-keep-open`), attaches `dsfr4drupal_picker/form-element.<element>`, and passes
  `theme` + `data_attribute_prefix` into `drupalSettings`.

## IconPicker element (`#[FormElement('dsfr4drupal_picker_icon')]`)

`PICKER_ELEMENT = 'icon'`. Uses the base behaviour unchanged. Docblock usage example shows
`#type`, `#default_value`, `#allowed_groups`, `#has_search`, `#keep_open` properties. Value = the
icon CSS class.

## PictogramPicker element (`#[FormElement('dsfr4drupal_picker_pictogram')]`)

`PICKER_ELEMENT = 'pictogram'`. Overrides `preRenderPicker()` to also attach
`drupalSettings[...]['pictograms_path']` — a map of each available pictogram value to
`base_path() . picker->getItemPath($pictogram)`, so the widget can preview the SVGs. Value =
`"<group>/<name>"`.

## Relationship to validation

The element restricts the offered options to the allowed groups and relies on core Select's
value-in-`#options` check; the persisted field value is independently re-checked by
`PickerAllowedValuesConstraint` against `picker->getItemsAvailable()` for the field's allowed groups
(see [fields/fields.md](../fields/fields.md)). Two layers keep a stored value within the known,
library-derived item set.
