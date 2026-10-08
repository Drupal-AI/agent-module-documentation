# advanced_text_formatter — agent start

Adds one field formatter, **Advanced Text** (plugin id `advanced_text`), for the
`string`, `string_long`, `text`, `text_long`, and `text_with_summary` field types. It
trims text (length + ellipsis + word boundary), optionally shows the field summary,
runs token replacement, filters markup (none / selected format / limit-allowed-HTML /
a chosen Drupal text format / deprecated PHP), and can link the value to its entity.
No admin form, no permissions, no services, no Drush (`configure` is null); everything is
set per field on **Manage display** and stored in the `entity_view_display` config.

- Apply the formatter, every setting key, defaults, and how to set it live via drush →
  [configure/advanced_text_formatter.md](configure/advanced_text_formatter.md)
- The `advanced_text` FieldFormatter plugin: field types, constants, render logic →
  [plugins/advanced_text_formatter.md](plugins/advanced_text_formatter.md)
