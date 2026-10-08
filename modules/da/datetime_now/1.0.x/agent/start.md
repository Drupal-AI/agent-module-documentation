# Datetime Now — agent index

Adds a **"Now"** button to core Date/time edit widgets that fills the inputs with the
current date and time. **Zero configuration**: no settings form, no configure route
(`configure: null`), no permissions, no Drush, no plugins, no config entity or state. Once
enabled it applies globally to every widget that renders the core `datetime` element.

- **How it works (hook, process callback, JS, which widgets get the button)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- It alters the core **`datetime` render element** via `hook_element_info_alter()`, so the
  button appears automatically on the `datetime_default` widget and the Datetime Range
  `daterange_default` widget (start + end) — no per-field opt-in.
- It does **not** appear on the `datetime_datelist` ("Select list") widget, which renders
  the `datelist` element, not `datetime`.
- The button has CSS class `datetime-now` inside a `datetime-now-wrapper`; behaviour comes
  from the `datetime_now/datetime_now` JS library. The Now time omits seconds when the time
  input's HTML5 `step` is a multiple of 60.
- Nothing to configure or store — the only way to "turn it off" for a field is to use a
  non-datetime widget (or disable the module).
