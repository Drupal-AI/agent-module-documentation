<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DateTime Reset (datetime_reset) — agent index

Adds an optional **"Reset" button** to core **Datetime** field widgets. Enabled per widget via a
third-party widget setting on *Manage form display*; clicking the button clears the date/time
inputs **client-side**. No package set. Depends only on core **`datetime`**. Core requirement
`^9.5 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

- **How to enable it, the hooks, the JS, config schema, and SmartDate/Date-range behavior** →
  [fields/reset-button.md](fields/reset-button.md)

## What it actually is

- **Procedural hooks only** — `datetime_reset.module`. No `src/`, no routes, no permissions, no
  services, no plugins, no Drush, no submodules.
- Adds a boolean **third-party widget setting** `datetime_reset.reset` to any widget extending core
  `Drupal\datetime\Plugin\Field\FieldWidget\DateTimeWidgetBase`.
- One asset library `datetime_reset/datetime_reset` (`js/datetime_reset.js`, depends
  `core/drupal.ajax`).
- Config schema `field.widget.third_party.datetime_reset` (`reset` boolean) in
  `config/schema/datetime_reset.schema.yml`.

## Mechanism (from source)

- `datetime_reset_field_widget_third_party_settings_form()` — adds the **"Reset button"** checkbox
  to the widget settings form, but only when the widget `instanceof DateTimeWidgetBase`.
- `datetime_reset_field_widget_settings_summary_alter()` — appends *"Display reset button."* or
  *"No reset button."* to the widget summary.
- `datetime_reset_field_widget_single_element_form_alter()` — when the widget's `reset` setting is
  on, sets `#datetime_reset['reset'] = TRUE` on the element's `value` (and `end_value` for Date
  range), or on `time_wrapper.value`/`time_wrapper.end_value` for SmartDate.
- `datetime_reset_element_info_alter()` registers `_datetime_reset_process_element` as a `#process`
  callback on the `datetime` element; that callback, when `#datetime_reset['reset']` is set, adds a
  `#type => button` **"Reset"** button (`class datetime-reset-button`, `#name = 'reset_' . #id`,
  `#ajax event click`) and attaches the library.
- `js/datetime_reset.js` (`Drupal.behaviors.dateTimeReset`) — on click, derives the container id
  from the button `name` (strips the `reset_` prefix), then empties that container's
  `input[type="date"]` and `input[type="time"]` values. `preventDefault`/`stopPropagation` stop the
  form from submitting.

## Notes

- The button only **clears the inputs in the browser**; nothing is saved until the editor submits
  the form. Normal core field validation/access applies to the eventual save.
