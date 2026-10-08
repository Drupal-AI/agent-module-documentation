# HTML Field Formatter — agent index

One field formatter (`id: html`) that renders text/string field values as raw HTML markup on
entity display. No config page (`configure` null), no permissions, no Drush, no config schema, no
dependencies. Single class: `src/Plugin/Field/FieldFormatter/HtmlFormatter.php`.

- **Select and configure the formatter, the `allowed_tags` setting, filtered vs unfiltered output** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Applies to field types: `text`, `text_long`, `text_with_summary`, `string`, `string_long`.
- Setting `allowed_tags` (newline-separated). **Empty (default) = unfiltered raw output via `#children`.**
  Non-empty = `#markup` + `#allowed_tags` (Xss::filter keeps only listed tags).
