# No Non-breaking Space Filter — agent index

Removes `&nbsp;` / U+00A0 and collapses the leftover spaces. Two entry points, both using
`_no_nbsp_eraser()`:

- **Text-format filter** plugin `filter_no_nbsp` (setting `preserve_placeholders`) — enable on a
  text format. → [configure/filter.md](configure/filter.md)
- **Field formatter** `no_nbsp` for text / text_long / text_with_summary — clean at display
  time without changing the field's format. → [plugins/formatter.md](plugins/formatter.md)

No configure route of its own, no permissions, no Drush, no new plugin type. The filter's
setting lives in the text format config at
`filter.format.<id>.filters.filter_no_nbsp` (schema `filter_settings.filter_no_nbsp`).

Key fact: the filter is `TYPE_TRANSFORM_IRREVERSIBLE`; `preserve_placeholders` (default false)
keeps an nbsp that sits directly inside an otherwise-empty tag like `<p>&nbsp;</p>`.
