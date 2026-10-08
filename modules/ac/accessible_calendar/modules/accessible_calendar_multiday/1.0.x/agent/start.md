<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Calendar - Multiday (accessible_calendar_multiday) — agent index

Optional submodule of **Accessible Calendar**. Makes events spanning multiple days render as one
continuous strip by adding multiday metadata + classes to calendar event rows and attaching a
CSS/JS library. Package **Accessible Calendar**. Depends on **`accessible_calendar`**. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The two preprocess hooks, the attributes/classes it adds, the library** →
  [plugins/multiday.md](plugins/multiday.md)

## What it actually is (from source)

- **No** plugins, routes, permissions, services, config, schema, or install file. Just one file:
  `accessible_calendar_multiday.module` with two hooks, plus `js/multiday.js`, `css/multiday.css`,
  and `accessible_calendar_multiday.libraries.yml` (library `accessible_calendar_multiday/multiday`,
  deps `core/drupal`, `core/once`).
- `accessible_calendar_multiday_preprocess_views_view_calendar()` attaches the
  `accessible_calendar_multiday/multiday` library to every calendar render.
- `accessible_calendar_multiday_preprocess_accessible_calendar_day()` runs after the parent's
  `template_preprocess_accessible_calendar_day()` and, per event row, adds
  `data-accessible-calendar-instance` / `data-accessible-calendar-instances` attributes and, when
  the event spans >1 day, the classes `is-multi` + `is-multi--first` / `is-multi--middle` /
  `is-multi--last` (position derived from the row's `instance` vs `instances` values set by the
  parent's `populateCalendar()`).

Disabling the submodule leaves the base calendar working; only the multiday attributes/classes and
their styling disappear.
