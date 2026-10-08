# File linktext formatter — agent index

A single field **formatter** for core `file` fields that uses another `string` field's value as the
link text instead of the filename. No config page (`configure` null), no permissions, no Drush.
Config schema for the formatter settings only. Effectively depends on core `file`.

- **The `file_fieldtext` formatter, its `use_field_as_link_text` setting, applicability, and render
  behaviour** → [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `file_fieldtext`, label "Link text from field", class `FieldTextFileFormatter`
  (extends core `FileFormatterBase`).
- Only applicable to **single-value** file fields (`isApplicable()` requires cardinality 1).
- Setting `use_field_as_link_text` (default `0` = disabled) names a sibling `string` field; its
  `->value` becomes the `file_link` `#description`.
