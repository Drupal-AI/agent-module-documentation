<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field types, widgets, formatters, validation

Two field types let a content type store a chosen DSFR icon or pictogram. Both store a single
`varchar(100)` `value` string; the difference is what the string means and how it renders.

## Field types (`src/Plugin/Field/FieldType/`)

- `PickerBase` (abstract, extends `FieldItemBase`):
  - `propertyDefinitions()` — one required `value` string property.
  - `schema()` — column `value` `varchar(100)`.
  - `defaultFieldSettings()` — adds `allowed_groups => []`.
  - `getConstraints()` — appends `PickerAllowedValuesConstraint` (see below).
  - `fieldSettingsForm()` — an *Allowed groups* checkboxes element (options from
    `getGroupsOptions()` → picker `getGroups()`/`getGroupLabel()`); empty = all groups allowed.
    `validateAllowedGroups()` collapses the value to an indexed array of selected group ids.
  - `isEmpty()` — empty when value is NULL or `''`.
- `IconPicker` — `#[FieldType(id: "dsfr4drupal_picker_icon", default_widget/formatter:
  "dsfr4drupal_picker_icon")]`, `PICKER_ELEMENT = 'icon'`. Value = the icon CSS class
  (`fr-icon-…`).
- `PictogramPicker` — `#[FieldType(id: "dsfr4drupal_picker_pictogram", …)]`,
  `PICKER_ELEMENT = 'pictogram'`. Value = `"<group>/<name>"`.

## Widgets (`src/Plugin/Field/FieldWidget/`)

- `PickerWidgetTrait` — the shared logic: `defaultSettings()` (`has_search => TRUE`),
  `settingsForm()` (a *Display search input* checkbox), `settingsSummary()`, and `formElement()`
  which builds the value element as `#type => 'dsfr4drupal_picker_<element>'` with
  `#default_value` from the item, `#allowed_groups` from the field setting, and `#has_search` from
  the widget setting.
- `PickerWidgetBase` (abstract, extends core `WidgetBase`) wires the trait in with aliased methods.
- `IconPickerWidget` (`id: dsfr4drupal_picker_icon`, `PICKER_ELEMENT = 'icon'`) and
  `PictogramPickerWidget` (`id: dsfr4drupal_picker_pictogram`, `PICKER_ELEMENT = 'pictogram'`).

The widget delegates its UI to the render elements — see
[elements/render-elements.md](../elements/render-elements.md).

## Formatters (`src/Plugin/Field/FieldFormatter/`)

- `IconPickerFormatter` (`id: dsfr4drupal_picker_icon`): setting `size` (default `md`; options
  xs/sm/md/lg via a `select` in `settingsForm()`). `viewElements()` renders each item as
  `#type => 'component'`, `#component => 'dsfr4drupal_picker:icon'`, props `icon` (=
  `Html::escape($item->value)`) and `size`.
- `PictogramPickerFormatter` (`id: dsfr4drupal_picker_pictogram`): injects the `pictogram` picker in
  `create()`. `prepareView()` sets, per item, `$item->path = base_path() . picker->getItemPath(value)`
  and `$item->isDsfr = in_array(value, flattened getItemsOriginal())` (custom pictograms → `img`,
  DSFR pictograms → inline `<svg><use>`). `viewElements()` renders `#component =>
  'dsfr4drupal_picker:pictogram'`, props `path` (= `Html::escape($item->path)`) and `is_dsfr`.

The SDC components live in `components/icon/` and `components/pictogram/`. The icon component sets
`aria-hidden` and `addClass(icon)`; the pictogram component uses `svg_attributes(path)` and emits an
`<svg>`/`<use>` (DSFR) or `<img>` (custom) — see [plugins/editor-embed.md](../plugins/editor-embed.md)
for the render/escaping details shared with the filters.

## Value validation (`src/Plugin/Validation/Constraint/`)

- `PickerAllowedValuesConstraint` (`#[Constraint(id: 'Dsfr4drupalPickerAllowedValues')]`), message
  *"The selected value is not allowed for this field."*
- `PickerAllowedValuesConstraintValidator` (injects the picker manager): for a non-empty value it
  builds the allowed set from `picker->getItemsAvailable()` restricted to the field's
  `allowed_groups`, and adds a violation with strict `in_array($value, $allowed, TRUE)` when the
  stored value is not part of that set. So a persisted field value is constrained to the known,
  library-derived item set for its configured groups.

## Operating it

Add a *DSFR for Drupal - Icon Picker* or *Pictogram Picker* field on **Manage fields**; optionally
tick specific *Allowed groups* on the field settings to restrict the offered subset. On **Manage
display**, pick the matching formatter (icon formatter has a size option). No permissions are added;
field creation/edit uses the normal Field UI permissions.
