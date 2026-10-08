<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# time_picker — field types, widgets, formatters

Two independent field types. Neither provides a bundle or base-field helper; you add them like any
field via Field UI (`Manage fields`) or `field_storage_config` / `field_config`.

## Field type: `time_picker`
`src/Plugin/Field/FieldType/TimePickerType.php`
- Annotation category `General`, label "Time Picker".
- `schema()`: single column `time` — `varchar` length 255.
- `propertyDefinitions()`: `time` (string), plus an unused `locate` (string, no schema column).
- `defaultStorageSettings()`: `time_picker_theme => theme_default`, `hour_format => 12h`
  (also `is_ascii`/`case_sensitive` FALSE, unused).
- `storageSettingsForm()`: two selects — theme (5 options) and hour format (`12h`/`24h`).
- `isEmpty()`: empty when `time` is empty.
- `default_widget = time_picker_widget`, `default_formatter = time_picker_formatter`.

### Widget: `time_picker_widget`
`src/Plugin/Field/FieldWidget/TimePickerWidget.php`
- `formElement()`: a `textfield` keyed `time`, class `timepicker`, `#size`/`#maxlength` 10, wrapped
  in a `fieldset` (class `time_fieldset`) when cardinality == 1.
- Attaches library `time_picker/time_picker` and `drupalSettings.time_picker =
  {hour_format, theme_color}` from field settings.
- `validate()`: empty → cleared; else regex per hour format (12h: `h:mm AM/PM`; 24h: `HH:MM`).
  Error message on mismatch is "Please enter valid time formate." (sic).
- `settingsForm`/`settingsSummary`/`defaultSettings` are empty — no widget-level settings.

### Formatter: `time_picker_formatter`
`src/Plugin/Field/FieldFormatter/TimePickerFormatter.php`
- `viewValue()` returns `$item->time` unchanged; `viewElements()` emits it as `#markup`. No settings.

## Field type: `time_range_picker`
`src/Plugin/Field/FieldType/TimeRangePickerType.php`
- Annotation category `General`, label "Time Range Picker".
- `schema()`: two columns `start`, `end` — each `varchar` length 255.
- `propertyDefinitions()`: `start`, `end`, plus unused `locate` (all string).
- Same `defaultStorageSettings()` and `storageSettingsForm()` (theme + hour format) as above.
- `isEmpty()`: returns `$start || $end` — note this uses the emptiness booleans, so the item is
  reported "empty" when *either* start or end is empty (a partially-filled range is treated as empty).
- `default_widget = time_range_picker_widget`, `default_formatter = time_range_picker_formatter`.

### Widget: `time_range_picker_widget`
`src/Plugin/Field/FieldWidget/TimeRangePickerWidget.php`
- `formElement()`: two `textfield`s `start` and `end`, class `time_range_picker`, `#maxlength` 10,
  wrapped in a `fieldset` (class `time_range_fieldset`) when cardinality == 1.
- Attaches `drupalSettings.time_range_picker = {hour_format, theme_color}`.
- `validate()`: same per-format regex as the single widget, applied to each input.
- `validateStartEnd()`: when both present, parses with `DrupalDateTime(date_default_timezone_get())`
  and errors if `start > end`. This is a naive comparison, so a range crossing midnight
  (e.g. `22:00`–`06:00`) fails validation.

### Formatter: `time_range_picker_formatter`
`src/Plugin/Field/FieldFormatter/TimeRangePickerFormatter.php`
- `viewValue()` returns `start`, or `end`, or `"start - end"` when both present; emitted as `#markup`.

## Runtime library
`time_picker.libraries.yml` → library `time_picker`:
- JS: `https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.js` (external) +
  local `js/drupal.time_picker.js`.
- CSS: local `css/time_picker.css` (theme group).
- Dependencies: `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/jquery.once`
  (the last no longer exists in Drupal 10/11; the module's own JS does not call `.once()`).

`drupal.time_picker.js` reads the `hour_format`/`theme_color` from `drupalSettings`, adds the theme
class to the fieldset, and calls `.timepicker({ twelveHour: <bool> })` on the `.timepicker` and
`.time_range_picker` inputs.
