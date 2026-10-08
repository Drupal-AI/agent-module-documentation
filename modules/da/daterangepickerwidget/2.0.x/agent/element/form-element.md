<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `daterangepicker` form element and shared trait

## Install & enable

```bash
composer require drupal/daterangepickerwidget   # pulls bower-asset/jquery-ui-daterangepicker ^0.5
drush en daterangepickerwidget -y
```

Base module depends only on core `field`. The JS libraries (comiseo daterangepicker, jQuery UI
theme, Moment.js, jQuery 1.8.3) are loaded from `/libraries/…`; the module ships an Asset-Packagist
composer requirement (`bower-asset/jquery-ui-daterangepicker`) to place them. `js/daterangepicker.js`
sandboxes its jQuery with `jQuery.noConflict(true)` (kept as `window.jQuery183`) so it does not
clash with the site's jQuery.

## Using the element

```php
$form['booking_dates'] = [
  '#type' => 'daterangepicker',
  '#title' => $this->t('Booking Dates'),
  '#required' => TRUE,
  '#min_date' => '+0d',          // no past dates
  '#max_date' => '+1y',          // up to a year ahead
  '#number_of_months' => 2,
  '#month_dropdown' => TRUE,
  '#year_dropdown' => TRUE,
  '#step_months' => 2,
  '#preset_ranges' => $preset_ranges,   // optional; see below
  // '#default_value' => ['start' => '2025-06-01', 'end' => '2025-06-15'],
];
```

The submitted value is a **JSON string** `{"start":"yy-mm-dd","end":"yy-mm-dd"}`.
`valueCallback()` `Json::decode()`s the raw input; `#default_value` may be a `{start,end}` array.

## Element definition — `DateRangePickerElement` (`src/Element/DateRangePickerElement.php`)

`#[FormElement('daterangepicker')]`, extends `FormElementBase`. `getInfo()` returns
`#input => TRUE`, empty default, and wires `#pre_render`, `#process`, `#element_validate` plus one
`#<option>` per entry of `DateRangePickerTrait::getDateRangePickerDefaultOptions()`.

- `processDateRangePicker()` — builds a nested `textfield` keyed by the element name, forces
  `#required => FALSE` on it (so the custom validator can emit the message), adds classes
  `daterangepicker` + `form-daterangepicker`, attaches library
  `daterangepickerwidget/jquery-ui-daterangepicker`, hard-pins `alt_format = 'yy-mm-dd'`, JSON-encodes
  any `#preset_ranges`, copies an array `#default_value`, and writes the mapped JS options into
  `drupalSettings.daterangepicker[<name>]` via `setJavascriptApiOptions()`.
- `validateElementSettings()` — throws `\Exception` if `#step_months > #number_of_months`.
- `validateDateRangePicker()` — if `#required` and the value is empty, sets a "@field is required"
  form error and clears the value.
- `getDateRangePickerConfiguration()` — reads each `#<option>` back, casting numeric strings to int.

## Options (`DateRangePickerTrait::getDateRangePickerDefaultOptions()`)

| Drupal option (`#…`) | Default | Maps to JS |
|---|---|---|
| `initial_text` | `Select date range...` | `initialText` |
| `apply_button_text` | `Apply` | `applyButtonText` |
| `clear_button_text` | `Clear` | `clearButtonText` |
| `cancel_button_text` | `Cancel` | `cancelButtonText` |
| `range_splitter` | `' - '` | `rangeSplitter` |
| `date_format` | `d M, yy` | `dateFormat` (jQuery UI datepicker format) |
| `number_of_months` | `2` | `datepickerOptions.numberOfMonths` |
| `show_week` | `FALSE` | `datepickerOptions.showWeek` |
| `max_date` | `+0d` | `datepickerOptions.maxDate` |
| `min_date` | `NULL` | `datepickerOptions.minDate` |
| `month_dropdown` | `FALSE` | `datepickerOptions.changeMonth` |
| `year_dropdown` | `FALSE` | `datepickerOptions.changeYear` |
| `first_day` | `0` | `datepickerOptions.firstDay` |
| `step_months` | `1` | `datepickerOptions.stepMonths` |
| `year_range` | `c-10:c+10` | `datepickerOptions.yearRange` |
| `disable_preset_ranges` | `FALSE` | `presetRanges` (encoded `[]` when TRUE) |

Two options exist only implicitly: `alt_format` (always `yy-mm-dd`, the storage format — do not
change) and `preset_ranges` / `default_value` (set on the element, not in the default set).

## Preset ranges

`#preset_ranges` is an array of `['text' => ..., 'dateStart' => "function(){…moment…}", 'dateEnd'
=> "…"]`. It is JSON-encoded server-side; `js/daterangepicker.js` parses it and turns each
`dateStart`/`dateEnd` **string body into a function** to feed the comiseo plugin (Moment.js is
available). An empty `#preset_ranges => []` or `#disable_preset_ranges => TRUE` hides the presets
column. Because these strings are developer-authored PHP/config (element definition or
`hook_form_alter`), they are not end-user input.

## Trait helpers reused across the project

`DateRangePickerTrait` (`src/DateRangePickerTrait.php`) also provides:

- `mapDrupalToJavascriptOptions()` — the option-name map (nested `datepickerOptions.*` where noted).
- `buildDateRangePickerOptionsForm(&$form, $default_values)` — renders the shared options sub-form
  (used by the field widget settings form, the Views filter expose form, and the BEF config form).
- `setJavascriptApiOptions(&$drupalSettings, $data)` / `setJavascriptApiOption()` — recursively
  write mapped options into `drupalSettings`, encoding `disable_preset_ranges` to `[]` when set and
  skipping it when unset.
- `getSummary($data)` — human-readable settings summary lines.
- `validateDateRangePickerOptions($form, $form_state, $values)` — shared validator enforcing
  `step_months <= number_of_months`.

No config schema, permissions, routes, or services are defined by the base module.
