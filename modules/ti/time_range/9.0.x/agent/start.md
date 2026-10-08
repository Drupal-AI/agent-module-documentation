# Time Range — agent index

One field **widget** (`time_range`) for the core **Date range** (`daterange`) field type that
shows only start-time and end-time inputs (date element hidden). Stores no data of its own —
core Date range holds the value. **No configure route, no permissions, no Drush, no plugin
types.** Its only persistent state is the widget choice + its two settings on an
`entity_form_display`.

- **Select & configure the widget (settings, where it's stored, how to swap it on)** →
  [plugins/time-range-widget.md](plugins/time-range-widget.md)

Key facts:
- Widget id `time_range`, label "Time range"; applies to field type `daterange`.
- Settings: `start_label` (default "Start time"), `end_label` (default "End time"); schema
  `field.widget.settings.time_range`.
- Selection lives at `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type: time_range` with `settings.start_label` / `settings.end_label`.
- Requires core `datetime` + `datetime_range`.
