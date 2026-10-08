<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bef_daterangepicker` Better Exposed Filters widget

## Install & enable

```bash
composer require drupal/better_exposed_filters   # if not already present (^7.0)
drush en drpw_bef -y   # base daterangepickerwidget enabled automatically
```

## When it applies — `isApplicable()`

`DateRangePickerFilter::isApplicable($filter, $filter_options)` returns TRUE only when the exposed
filter:

- is an instance of `\Drupal\views\Plugin\views\filter\Date` **or** has a non-empty `date_handler`,
- is **not** a grouped filter (`!$filter->isAGroup()`), and
- uses operator `between` or `not between`.

So on a View's exposed core Date filter set to "Is between", the BEF settings offer
**jQuery UI Date Range Picker** as the widget.

## What it renders — `exposedFormAlter()`

`src/Plugin/better_exposed_filters/filter/DateRangePickerFilter.php`, extends `FilterWidgetBase`,
uses `DateRangePickerTrait`.

- Resolves the filter field id (`getExposedFilterFieldId()`), handling the core exposed-filter
  wrapper (`{field}_wrapper`).
- Adds a textfield `{field_id}_daterangepicker` (class `daterangepicker`, `autocomplete=off`),
  attaches library `daterangepickerwidget/jquery-ui-daterangepicker`, hard-pins
  `alt_format = 'yy-mm-dd'`, and writes mapped JS options to
  `drupalSettings.daterangepicker[{field_id}_daterangepicker]` plus a
  `drupalSettings.better_exposed_filters.daterangepicker[...]['field_id']` pointer.
- Converts the real `min`/`max` inputs to **hidden** fields (class `bef-daterangepicker`,
  `data-daterangepart = start|end`) and visually hides the original wrapper.

## Client behavior

Handled by the base module's `js/daterangepicker.js`. On `daterangepickerchange` it parses the
picker's JSON value and sets the hidden inputs to `min = start + '00:00:00'` and
`max = end + '23:59:59'`; on `daterangepickerclear` it empties all three. This makes the standard
core Views "between" filter run unmodified against the selected span.

## Configuration form

- `defaultConfiguration()` = `['daterangepicker' => DateRangePickerTrait::getDateRangePickerDefaultOptions()]`
  + parent.
- `buildConfigurationForm()` adds a "Date Range Picker options" details section via
  `buildDateRangePickerOptionsForm()` (initial text, button labels, date format, months, min/max,
  first day, step months, year range, dropdowns, disable presets).
- `validateConfigurationForm()` runs `validateDateRangePickerOptions()` (`step_months <=
  number_of_months`).
- `getDateRangePickerConfiguration()` reads options from `$this->configuration['daterangepicker']`,
  casting numeric strings to int.

## Custom preset ranges on an exposed filter

Alter the exposed form element in `hook_form_views_exposed_form_alter()` and set
`#preset_ranges` (JSON-encodable array of `['text', 'dateStart', 'dateEnd']` where the date bounds
are Moment.js function bodies) on the `{field}_daterangepicker` element — these are
developer-authored, not visitor input.
