# Formatter Suite — agent index

18 general-purpose field formatter plugins for numbers, dates/timestamps, text, links, email, files,
images, and entity/user references. Selected per field on *Manage display* (Field UI) and in Views. No
global settings page (`configure` null), no permissions, no Drush, no config schema of its own (settings
live in each field's display config). Depends on core `field` + `system`. Maintained by SDSC.

- **Every formatter id, the field types it targets, and its key settings** →
  [configure/formatters.md](configure/formatters.md)

Key facts:
- Plugins in `src/Plugin/Field/FieldFormatter/`, all ids prefixed `formatter_suite_`.
- Settings are stored on the `entity_view_display` (or Views field) config for the field, not globally.
- Admin-entered strings (custom title text, list separators, button labels) are run through
  `Xss::filterAdmin()` before output; a JS library backs the expand/collapse text formatter.
