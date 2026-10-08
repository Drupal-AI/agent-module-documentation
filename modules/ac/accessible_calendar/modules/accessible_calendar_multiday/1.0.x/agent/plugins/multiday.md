<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiday preprocessing & library

Everything lives in `accessible_calendar_multiday.module` (two hooks) plus the
`accessible_calendar_multiday/multiday` library. Enable with
`drush en accessible_calendar_multiday` (pulls in `accessible_calendar`). No configuration.

## Hooks

### `accessible_calendar_multiday_preprocess_views_view_calendar(&$variables)`

Runs on the parent's `views_view_calendar` template. Appends
`$variables['#attached']['library'][] = 'accessible_calendar_multiday/multiday'` so the multiday
CSS/JS load whenever a calendar renders.

### `accessible_calendar_multiday_preprocess_accessible_calendar_day(&$variables)`

Runs after the parent's `template_preprocess_accessible_calendar_day()` (which already populated
`$variables['rows']`, each row carrying `#values` with `instance` and `instances` computed in
`AccessibleCalendarBase::populateCalendar()`: `instance` = day index within the event's span,
`instances` = total span length in days). For each row it:

- sets attribute `data-accessible-calendar-instance` = `values['instance']` (default 0);
- sets attribute `data-accessible-calendar-instances` = `values['instances']` (default 0);
- if `instances > 0`, adds class `is-multi`, then exactly one of:
  - `is-multi--first` when `instance == 0`,
  - `is-multi--last` when `instance == instances`,
  - `is-multi--middle` otherwise.

Single-day events (`instances == 0`) get the two data attributes but **no** `is-multi*` class.

## Library

`accessible_calendar_multiday.libraries.yml` → `multiday`: `css/multiday.css` (component) +
`js/multiday.js`; deps `core/drupal`, `core/once`. The JS/CSS consume the attributes/classes above
to draw connected multiday spans; override or replace them in your theme for custom multiday
visuals.

## Notes

- Purely presentational: it only decorates already-rendered rows. It reads no request/remote input
  and adds no access surface — event rows are still produced by the base module through the View's
  own row plugin, so entity/field access is unchanged.
