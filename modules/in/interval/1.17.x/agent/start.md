<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Interval Field — agent index

Provides one field type **`interval`** = integer count + period machine name (e.g. `3` +
`day`). No settings form, no `configure` route, no permissions, no Drush. Periods are
plugin definitions loaded from `*.intervals.yml` files.

- **Add an interval field, choose widget/formatter, restrict periods** →
  [configure/field.md](configure/field.md)
- **Define a custom period (or alter built-ins) via `*.intervals.yml`** →
  [plugins/periods.md](plugins/periods.md)
- **Apply an interval to a `\DateTime`, read the value, the form element** →
  [api/apply-interval.md](api/apply-interval.md)

Key facts:
- Field type `interval` — columns `interval` (int) + `period` (varchar 20, default `day`).
- Widget `interval_default`; setting `allowed_periods` (array; empty = all periods).
- Formatters: `interval_default` (Plain), `interval_php` (PHP date/time), `interval_raw` (Raw).
- Plugin manager service `plugin.manager.interval.intervals`; alter hook `hook_intervals_alter()`.
- Built-in periods: second, minute, hour, day, week, fortnight, month, quarter, year.
