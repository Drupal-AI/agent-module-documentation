<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Partial Datelist (partial_datelist) — agent index

Lets administrators **hide individual dropdowns** (year, month, day, hour, minute, second) in core's
"Select list" datelist widgets, so a date/datetime field can collect only the parts that matter
(e.g. year only, or year+month). It defines no field, widget, or formatter of its own: it attaches
per-widget **third-party settings** to the two core datelist widgets (`datetime_datelist`,
`daterange_datelist`) and, at form-build time, removes the hidden parts from each element's
`#date_part_order`. Configuration is entirely per field-widget on *Manage form display* — there is no
settings page and no routes.

The whole module is four attribute-based hooks on one class,
`Drupal\partial_datelist\Hook\PartialDatelistHooks`: a checkboxes control on the widget settings
(`field_widget_third_party_settings_form`), a widget-summary line
(`field_widget_settings_summary_alter`), the form rewrite (`field_widget_complete_form_alter`), and
`help`. A behavioral caveat to verify per field: a hidden dropdown is not removed from the stored
value, it just stops being asked — it still contributes a default (hiding `second` yields `0`), so
confirm hidden parts have sensible defaults.

- Depends on: `drupal:datetime` (core). Range support additionally needs `datetime_range` (soft —
  the daterange branch is guarded by `class_exists`).
- Core: `^11.1 || ^12`. Package: `User interface`.
- No settings page / `configure` route, no routes, no permissions, no services (beyond the hook
  class), no drush, no plugin types, no submodules. Provides config schema (widget third-party
  settings). One `hook_post_update`.

## What you'd do → where

- **Hide date/time dropdowns on a datelist field; config keys, the part→setting map, the form-alter
  mechanism, and how to set it from code** → [fields/widget-settings.md](fields/widget-settings.md)

## Key facts (real machine names)

- Hook class: `Drupal\partial_datelist\Hook\PartialDatelistHooks` (service id same as class, autowired
  in `partial_datelist.services.yml`). Hooks: `help`, `field_widget_third_party_settings_form`,
  `field_widget_settings_summary_alter`, `field_widget_complete_form_alter`.
- Targets widget ids: `datetime_datelist`, `daterange_datelist` only. Not `datetime_timestamp`, not
  the HTML5/calendar widget.
- Third-party settings namespace: `partial_datelist`; key `hidden_datelist_parts` →
  `hide_year`/`hide_month`/`hide_day`/`hide_hour`/`hide_minute`/`hide_second` (booleans).
- Config schema type: `field.widget.third_party.partial_datelist`
  (`config/schema/partial_datelist.schema.yml`).
- Constant class `Drupal\partial_datelist\PartialDatelistConfig`: `DATELIST_PARTS` (part→setting/label/
  context map), `DATELIST_SETTINGS_CLASS_NAME` = `partial-datelist-settings`.
- Field `datetime_type` gating: `date` shows Year/Month/Day; `datetime` shows all six.
- Post update: `partial_datelist_post_update_normalize_hidden_datelist_parts` (casts legacy values to
  bool). Help route: `help.page.partial_datelist`.
