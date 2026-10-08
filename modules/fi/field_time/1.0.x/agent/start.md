# Field Time — agent index

Two clock-time field types — `time` (single `HH:MM:SS`) and `time_range` (start/end) — each with a
widget + formatter, plus a reusable `time` render element. Stored as native DB `TIME` columns. No
admin page (`configure` null), no permissions, no Drush. Config schema for field/widget/formatter
settings. Requires core `datetime`.

- **The field types, widgets, formatters, their settings, the `time` render element, and range
  validation** → [configure/fields.md](configure/fields.md)

Key facts:
- Field types: `time` (property `value`, char(8)) and `time_range` (properties `from`/`to`), default
  widget/formatter wired to each.
- Widgets `time_widget` / `time_range_widget`: settings `enabled` (add seconds step) and `step`;
  values normalized to `H:i:s` on save.
- Formatters `time_formatter` / `time_range_formatter`: PHP `date()` format string `time_format`
  (default `h:i a`); range adds `timerange_format` template (`start`/`end` placeholders, default
  `start ~ end`).
- `time_range` validates end > start via a `Callback` constraint.
- Render element `#type => 'time'` (`TimeElement`) → HTML5 `<input type="time">`.
