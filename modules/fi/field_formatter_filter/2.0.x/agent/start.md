# Field Formatter Filter — agent index

Adds an "Additional Text Filter/Format" select to text-field formatters on *Manage display*; at render
time the chosen text format re-processes the field for that view mode only. Hook-driven, no plugins.
Depends on core `filter`. No config page (`configure` null), no permissions.

- **The formatter setting, where it's stored, how rendering is overridden** →
  [configure/formatter-setting.md](configure/formatter-setting.md)

Key facts:
- Applies to field types `text`, `text_long`, `text_with_summary` only.
- Setting stored as `third_party_settings.field_formatter_filter.format` (a filter format id, or falsey
  for `<none>`) on `core.entity_view_display.*` components. Schema:
  `field.formatter.third_party.field_formatter_filter`.
- `hook_preprocess_field()` sets each item's `#format` to that id, so `ProcessedText::preRenderText`
  uses it instead of the field's stored format — display-only, does not change stored data.
- Deleted/invalid selected format → logged warning + default rendering.
- No formatter plugin classes exist in 2.0.x (README's "Remainder after trimming" formatter is absent).
