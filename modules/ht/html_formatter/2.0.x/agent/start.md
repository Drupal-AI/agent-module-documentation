# HTML Formatter — agent index

Field *formatters* that wrap a field's value in a configurable HTML tag + class, with an
optional link to the host entity. Chosen per field on **Manage display**; no global config
page (`configure` null), no permissions, no Drush, no plugin types of its own. Depends on core
`field` + `link`. Provides a config schema for the three formatter settings.

- **The four formatters, their field types, the three settings, where they're stored, the template, and the trust caveat** →
  [configure/formatters.md](configure/formatters.md)

Key facts:
- Formatter ids → field types:
  - `html_field_formatter` → `text`, `text_long`, `text_with_summary`, `string`, `string_long`
  - `html_field_formatter_datetime_default` → `datetime`
  - `html_field_formatter_timestamp` → `timestamp`, `created`, `changed`
  - `html_field_formatter_entity_reference_label` → `entity_reference`
- Settings (all three via `HtmlFormatterTrait`): `tag` (string), `class` (string), `link` (bool).
- Stored in `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.settings` (schema `field.formatter.settings.html_field_formatter*`).
- Renders via theme hook `html_formatter` / `templates/html-formatter.html.twig`:
  `<{{ tag }}{{ attributes }}>{{ value }}</{{ tag }}>` (tag omitted if blank).
