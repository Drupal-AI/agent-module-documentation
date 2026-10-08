<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Days ago (days_ago) — agent index

A single field formatter that renders a `datetime` or `timestamp` field as the whole number of
days between that value and now. Package `Custom`. **No dependencies** beyond Drupal core; core
requirement `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x (packaged 1.0.1).

- **The formatter, its behavior, how to enable it, and its edge cases** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `DaysAgoFieldFormatter` (id **`days_ago_field_formatter`**, label *"Days ago"*), in
  `src/Plugin/Field/FieldFormatter/DaysAgoFieldFormatter.php`, extending core's `FormatterBase`.
  `field_types = { "datetime", "timestamp" }`.
- **No** field type, **no** widget, **no** settings form (the `defaultSettings()`/`settingsForm()`/
  `settingsSummary()` overrides are empty stubs), **no** config object or schema, **no** routes,
  **no** permissions, **no** services, **no** hooks, **no** Drush.
- It changes only how a date/time field is **displayed**, selected per view-display on
  *Manage display*.

## Mechanism (from source)

- `viewElements()` loops the items and emits `['#markup' => $this->viewValue($item)]` per delta.
- `viewValue()` sets `$to` to `\Drupal::time()->getCurrentTime()`. For a `TimestampItem` with
  `value > 0` it builds `$from` from that Unix timestamp; a timestamp `<= 0` returns the string
  `"0"`. For any other (i.e. `datetime`) item it does `new \DateTime($item->value)` on the stored
  string. Result is `$to->diff($from)->format("%a")` — the **absolute** whole-day count.
- Output is `nl2br(Html::escape($daysAgo))`; the value is only a number, so the escape is defensive
  and there is no unescaped user/remote data in the markup.

## Caveats

- The diff is absolute — a **future** date shows a positive day count, same as a past one; the
  string contains no "ago"/"in" wording, hours or months.
- `datetime` items are not null-guarded: an empty value passed to `new \DateTime('')` yields "now"
  (0 days) rather than an error, but a malformed stored string would throw.
