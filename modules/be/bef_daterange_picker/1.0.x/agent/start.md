<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEF DateRange Picker (bef_daterange_picker) — agent index

A Better Exposed Filters widget plugin that turns a Views "is between" date exposed filter into a Bootstrap Daterangepicker calendar. Version 1.0.3, core `^10 || ^11`.

## Dependencies
- Drupal core `views`.
- `better_exposed_filters` (`drupal/better_exposed_filters` `^7.1`).
- JS assets: `npm-asset/daterangepicker` `^3.1` (Bootstrap Daterangepicker) + bundled Moment.js, expected under `/libraries/daterangepicker/` (installed via asset-packagist). No hard PHP-library composer requirement beyond these.

## What it provides
- One plugin instance of BEF's `BetterExposedFiltersFilterWidget` type: `BefDateRangeWidget` (id `bef_daterange_picker`) in `src/Plugin/better_exposed_filters/filter/BefDateRangeWidget.php`. Does NOT define a new plugin type.
- A Drupal library `bef_daterange_picker/daterangepicker` (`bef_daterange_picker.libraries.yml`) — Moment.js, daterangepicker.js/.css, module JS/CSS, deps on jquery/drupal/drupalSettings/once.
- Two procedural hooks in `bef_daterange_picker.module`: `hook_form_views_exposed_form_alter()` and a helper `bef_daterange_picker_process_exposed_form()` that swap the Reset submit button for a link (core Views Reset bug workaround).
- Client behavior `Drupal.behaviors.befDateRangePicker` in `js/bef_daterange_picker.js`.

## What it does NOT provide
No routes, no permissions, no services, no entities, no Drush, no menu links, no `config/` (no install config or config schema of its own). All settings live inside the host view's BEF widget config.

## Config keys (per-filter, stored in the view's BEF settings)
`default_date_min`, `default_date_max` (PHP relative-date strings), `preset_ranges` (newline `Label|start|end`), `always_show_calendars` (bool). See `defaultConfiguration()` / `buildConfigurationForm()`.

## Solution docs
- Widget behavior, applicability, config, and the Reset workaround: [agent/plugins/bef_daterange_widget.md](plugins/bef_daterange_widget.md)
