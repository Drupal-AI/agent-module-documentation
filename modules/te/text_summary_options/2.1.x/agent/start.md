# Text Summary Options — agent index

Adds three site-builder settings to **`text_with_summary`** fields — Show summary, Summary
help text, Summary Placeholder — set on the field's edit form. No settings page, no configure
route, no plugins, no Drush, no permissions. Persistent state is a **third-party setting on
the `FieldConfig`** (not the form display). Depends on nothing beyond core.

- **The three settings, where they are stored, the UI, and exactly what each does to the edit
  widget** → [configure/summary-options.md](configure/summary-options.md)

Key fact: settings live at `field.field.<entity>.<bundle>.<field>` →
`third_party_settings.text_summary_options` with keys `show_summary` (bool), `summary_help`
(string), `summary_placeholder` (string). Only offered for `text_with_summary` field type.
