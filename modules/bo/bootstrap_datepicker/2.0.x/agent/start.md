<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Datepicker — agent index

Provides a field **widget** `bootstrap_date_widget` (for core `datetime` fields) and a render
element `bootstrap_datepicker` that render dates with the jQuery uxsolutions bootstrap-datepicker
popup. No admin page (`configure: null`), no permissions, no Drush, no config schema, no config
entities of its own — everything is per-field widget **settings** on *Manage form display*.

- **Select & configure the widget on a datetime field; where settings live; the option keys** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget plugin id: `bootstrap_date_widget`; applies to field type `datetime`; extends
  `DateTimeWidgetBase`.
- Settings are stored on the form display component: `core.entity_form_display.<entity>.<bundle>.<mode>`
  → `content.<field>.type = bootstrap_date_widget`, `content.<field>.settings.<key>`.
- Requires the JS/CSS library at `/libraries/bootstrap-datepicker`
  (`bootstrap_datepicker.libraries.yml`, library `bootstrap_datepicker/datepicker`); the popup
  will not render without it (the field still saves).
- ~40 option keys mirror the JS plugin: `format`, `language`, `week_start`, `start_view`,
  `autoclose`, `today_btn`, `clear_btn`, `start_date`/`end_date`, `days_of_week_disabled`, etc.
