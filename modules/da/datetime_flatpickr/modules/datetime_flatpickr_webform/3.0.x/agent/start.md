<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime Flatpickr for Webform — agent index

Submodule of `datetime_flatpickr`. Adds one **Webform element**, `flatpickr_date`, so a flatpickr
date/time picker can be used inside Webforms. No config, permissions, routes, or Drush of its own.
Depends on `webform`, `datetime`, `datetime_flatpickr`.

- **The `flatpickr_date` element: how to add it, its settings, where it's stored in a webform** →
  [configure/element.md](configure/element.md)

Key facts:
- Element plugin id `flatpickr_date` (class `FlatpickrDate extends WebformElementBase`), category
  "Date/time elements", default `dateFormat` `Y-m-d`.
- Reuses `DateTimeFlatPickrWidgetTrait`, so the same flatpickr settings apply (see the parent module's
  [configure/widget.md](../../../../3.0.x/agent/configure/widget.md)); `prepare()` renders it via the
  `datetime_flatpickr` form element.
- In a webform's `elements` YAML an instance is `'#type': flatpickr_date`.
