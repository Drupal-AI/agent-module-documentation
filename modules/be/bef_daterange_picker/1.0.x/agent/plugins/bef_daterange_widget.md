<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BefDateRangeWidget — BEF filter widget

File: `src/Plugin/better_exposed_filters/filter/BefDateRangeWidget.php`
Annotation: `@BetterExposedFiltersFilterWidget(id = "bef_daterange_picker", label = "BEF DateRange Picker")`
Extends `Drupal\better_exposed_filters\Plugin\better_exposed_filters\filter\FilterWidgetBase`, implements `ContainerFactoryPluginInterface`.

## Install / enable
1. Configure `asset-packagist.org` in root `composer.json` and an `installer-paths` entry mapping `vendor:npm-asset` to `web/libraries/{$name}`.
2. `composer require drupal/bef_daterange_picker` (pulls `npm-asset/daterangepicker:^3.1`), so `daterangepicker.js`, `daterangepicker.css`, and `moment.min.js` land under `web/libraries/daterangepicker/`.
3. `drush en bef_daterange_picker && drush cr`.

## When it is selectable (`isApplicable()`)
Returns TRUE when the Views filter is a `Drupal\views\Plugin\views\filter\Date` instance (or exposes `date_handler`) AND is not a grouped filter (`!$filter->isAGroup()`). In practice: add a date field as an exposed filter, set operator to **Is between**, enable BEF for it, then pick "BEF DateRange Picker" as the widget.

## Configuration (`defaultConfiguration()` / `buildConfigurationForm()`)
Stored in the host view's BEF settings (no standalone config object). Keys:
- `default_date_min` (textfield, default `first day of this month`) — PHP relative-date string for the start bound, or empty.
- `default_date_max` (textfield, default `last day of this month`) — PHP relative-date string for the end bound, or empty.
- `preset_ranges` (textarea, default `DEFAULT_PRESET_RANGES` const) — one preset per line, `Label|start|end`. Default lines: Today, Yesterday, This Week, Last Week (`this week`/`last week`), This Month, Last Month.
- `always_show_calendars` (checkbox, default FALSE) — show calendars immediately vs. only on "Custom Range".

There is no config schema shipped by this module; the widget's stored values ride inside better_exposed_filters' schema.

## Render-time behavior (`exposedFormAlter()`)
- Resolves the exposed field element (handles a `<field>_wrapper` wrapping element), calls `parent::exposedFormAlter()`.
- Attaches library `bef_daterange_picker/daterangepicker` and sets `$form['#has_bef_daterange_picker'] = TRUE` (marker for the Reset workaround).
- Parses `preset_ranges` line by line. Each `Label|start|end` (exactly 3 pipe parts) is converted server-side with `\DateTime` to ISO `Y-m-d`. Week presets containing `this week`/`last week` are recomputed from `system.date` `first_day` (0=Sun…): it finds the week start via `($current_day - $first_day + 7) % 7` and spans 6 days. Invalid date strings are skipped and logged as a warning on the `bef_daterange_picker` logger channel.
- Emits `drupalSettings.customDatePicker.config[<field_id>]` = `{presets:[…], alwaysShowCalendars:bool}` and `drupalSettings.customDatePicker.firstDay`.
- For each of the `min`/`max`/`value` sub-elements present: guarantees a `#default_value` (prevents "Undefined array key"), adds class `bef-daterange-picker`, and applies `default_date_*` when the input is empty — parsing the offset to `Y-m-d` and storing it in `data-initial-value`. For the `max` field it stores `#default_value` as the parsed date **plus one day** so Drupal's "between" filter includes the whole last day. Adds a hidden `type=date` element so the filter accepts absolute dates.

## Reset-button workaround (`bef_daterange_picker.module`)
`hook_form_views_exposed_form_alter()` (and the standalone helper `bef_daterange_picker_process_exposed_form()`) run only when `$form['#has_bef_daterange_picker']` is set (or an element carries the `bef-daterange-picker` class). They replace `$form['actions']['reset']` with a `#type => link` pointing at `\Drupal::service('path.current')->getPath()` (no query string), sidestepping the core Views Reset bug that throws "Undefined array key 'min'" for numeric/date filters. Weight preserved from the original button (default 100).

## JS (`js/bef_daterange_picker.js`, `Drupal.behaviors.befDateRangePicker`)
Uses `once('bef-daterange-picker', …)`. Initializes only on the `[min]` input, finds the sibling `[max]` input, hides both plus their labels, and inserts a read-only display input (`.custom-date-picker-display`) with inline-SVG calendar/chevron icons. Retries up to 10×100ms if `moment`/`$.fn.daterangepicker` aren't loaded yet. Builds picker `ranges` from `drupalSettings.customDatePicker.config[fieldId].presets` (falls back to hardcoded default ranges), honors `firstDay` in the locale, display format `MMM D, YYYY`, value format `YYYY-MM-DD`. On apply/callback it writes the start to `[min]`, writes end **+1 day** to `[max]`, and triggers `change` for Views AJAX; cancel clears all three.

## Operating notes
- Pure UX layer over a core Views date filter — the actual filtering/query is done by core Views; this widget only shapes the exposed inputs and default values.
- Configuration is admin-only (Views UI). No end-user-facing routes or permissions.
- If presets don't appear, check `Label|start|end` format and the `bef_daterange_picker` log channel for skipped invalid dates; clear caches after changes.
