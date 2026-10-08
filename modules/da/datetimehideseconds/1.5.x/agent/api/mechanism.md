<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The whole module is `datetimehideseconds.module` (four hooks) plus a one-key config schema.
There is no service, plugin, or class. This is a **widget alteration**, not a new widget.

## The four hooks

1. `hook_field_widget_third_party_settings_form()` — adds the **"Hide seconds"** checkbox to the
   widget settings form, but only when `$widget instanceof DateTimeWidgetBase`. Default value is
   the current third-party setting `datetimehideseconds.hide`.

2. `hook_field_widget_settings_summary_alter()` — appends "Hide seconds." or "Do not hide
   seconds." to the widget summary line on the Manage form display page.

3. `hook_field_widget_single_element_form_alter()` — at form build time, if the widget's
   third-party setting `datetimehideseconds.hide` is TRUE, it flags the render element:
   `$element['value']['#datetimehideseconds']['hide'] = TRUE;` (and `$element['end_value']` too,
   for Datetime Range fields).

4. `hook_element_info_alter()` — registers `datetimehideseconds_process_element` as a `#process`
   callback on the `datetime` render element.

## The process callback

`datetimehideseconds_process_element()` runs on every `datetime` element but only acts when the
`#datetimehideseconds['hide']` flag set in hook #3 is present. When it fires it:

- sets the time input's `title` hint to a `h:i` example,
- sets `#date_time_format = 'H:i'` (unless `#date_time_element === 'none'`),
- truncates any existing `time` `#value` to its first two `:`-separated parts (drops seconds),
- sets `#attributes['step'] = 60` on the time input — this is what makes an HTML5
  `<input type="time">` hide the seconds spinner in supporting browsers.

## Consequences an agent should know

- It only alters the **editing widget**. Stored field values and formatters are unchanged; a
  saved time simply has `:00` seconds because the widget never lets you enter otherwise.
- No effect on date-only datetime fields (no time input) — the checkbox description says so.
- The trigger is entirely the per-component third-party setting; there is no global on/off.
- Because it keys off `DateTimeWidgetBase`, any core-or-contrib widget subclassing that base
  (datetime and datetime_range) inherits the checkbox automatically.
