<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiselect Dropdown — field widget

Widget id `multiselect_dropdown` (`Drupal\multiselect_dropdown\Plugin\Field\FieldWidget\MultiselectDropdownWidget`,
extends `OptionsWidgetBase`, `multiple_values: TRUE`).

## Applicability
- Field types: `entity_reference`, `list_integer`, `list_float`, `list_string`.
- `isApplicable()` returns true only when the field storage **cardinality is not 1**
  (i.e. multi-value or unlimited). Single-value fields won't offer this widget.
- Select it on *Manage form display* for the bundle. It attaches the
  `multiselect_dropdown/field_widget` library and renders a `#type => multiselect_dropdown`
  element with `#modal_breakpoint = ModalType::Dialog` (non-modal dialog).

## Settings (schema `field.widget.settings.multiselect_dropdown`)
Configured via the widget's gear on *Manage form display*:
- `label_aria` (required) — accessible label on the toggle button. Default "Toggle the list of items".
- `label_none` (required) — default "No Items Selected".
- `label_all` (required) — default "All Items Selected".
- `label_single` (required) — default "%d Item Selected" (`%d` = count).
- `label_plural` (required) — default "%d Items Selected".
- `label_select_all` — select-all button label; blank = omit.
- `label_select_none` — deselect-all button label; blank = omit.
- `search_title` — search field label; blank = omit the search field.
- `search_title_display` — one of before/after/invisible/attribute (shown/required only when `search_title` filled).
- `search_placeholder` — search placeholder (visible only when `search_title` filled).
- `search_character_threshold` — integer, min 0 (visible/required only when `search_title` filled).

Note the field widget does **not** expose submit/clear buttons — per the README, buttons
that submit the form from inside the dropdown are only available in the Views/BEF context,
not the field widget. Selecting/deselecting updates the underlying checkboxes directly.

`settingsSummary()` prints the label set and whether the select-all / select-none buttons
are enabled.
