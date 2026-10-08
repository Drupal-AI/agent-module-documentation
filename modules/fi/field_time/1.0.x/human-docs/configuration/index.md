# Configuration

Field Time has no settings page. You add its fields through the normal Field UI and
configure the widget and formatter per bundle, just like any other field.

## Add a Time or Time Range field

1. Go to a bundle's fields — for example **Structure → Content types → Event →
   Manage fields** — and click **Add field**.
2. Choose one of:
   - **Time « human »** — a single time of day (`HH:MM:SS`), stored in a native
     `TIME` column.
   - **Time Range « Human »** — a start (`from`) and end (`to`) pair, stored as two
     `TIME` columns. The end must be strictly later than the start; the field
     validates this automatically and shows an error on the *to* value if the range
     is invalid.
3. Save the field.

## Widget settings (Manage form display)

On the bundle's **Manage form display** tab, both the **Time** and **Time Range**
widgets render an HTML5 `<input type="time">` (the browser's native time picker) and
share the same two settings:

- **Add seconds parameter to input widget** (off by default) — when on, adds a
  `step` to the input so seconds can be entered. Leave off if you only need
  hours/minutes.
- **Step to change seconds** (default `5`) — the seconds increment for the picker.
  Only shown when the seconds option above is enabled.

Whatever is submitted is normalised to `HH:MM:SS` on save.

## Formatter settings (Manage display)

On the bundle's **Manage display** tab, set the format for the field.

### Time formatter

- **Time Format** (default `h:i a`) — a PHP `date()`-style format string applied to
  the stored time. Common choices:
  - `h:i a` → 12-hour with am/pm (e.g. *2:30 pm*).
  - `H:i` → 24-hour (e.g. *14:30*).
  - Add `s` for seconds (e.g. `H:i:s`).

### Time Range formatter

- **Time Range Format** (default `start ~ end`) — a template string in which the
  literal words `start` and `end` are replaced by the formatted start and end times.
  So `start ~ end`, `start – end`, or `From start to end` all work.
- **Time Format** (default `h:i a`) — the `date()` format applied to *each* end of
  the range.

The UI shows the available format letters: `a`/`A` (am/pm), `g`/`G`/`h`/`H`
(hours), `i` (minutes), `s` (seconds), and `B` (Swatch internet time).

## Notes

- Because values are stored as real DB `TIME` columns, they **sort and filter
  correctly** as times — useful in Views.
- The **Time Range** end-after-start rule is enforced on save, so you don't need a
  separate validation constraint.
- Developers can reuse the underlying `#type => 'time'` render element on custom
  forms — see the sibling [`agent/`](../agent/start.md) docs.
