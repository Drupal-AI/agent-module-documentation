# Calendar Systems BEF — agent index

Adds Persian/Jalali datepicker support to Better Exposed Filters exposed date filters. Requires
`calendar_systems` + `better_exposed_filters`. No config, permissions, routes, or Drush.

How it works:
- `calendar_systems_bef_views_plugins_exposed_form_alter()` swaps the `bef` exposed-form plugin
  class → `Drupal\calendar_systems_bef\Plugin\views\exposed_form\CalendarSystemsBef`.
- `CalendarSystemsBef::exposedFormAlter()` runs `parent::exposedFormAlter()`, then — only if
  `_calendar_systems_factory()->getCalendarName() === 'persian'` — removes
  `core/jquery.ui.datepicker` / `better_exposed_filters/datepickers` from `#attached['library']`
  and adds `calendar_systems_bef/picker`.
- Library `calendar_systems_bef/picker` depends on `calendar_systems/picker`; its JS
  (`calendar_systems_bef.js`, behavior `calendarSystemsBef`) inits a persian datepicker on
  `.bef-datepicker` using BEF's `drupalSettings.better_exposed_filters.datepicker` options.
- Non-Persian calendars: no change (BEF's normal datepicker is left in place).

No solution docs beyond this index — the submodule is a single plugin swap.
