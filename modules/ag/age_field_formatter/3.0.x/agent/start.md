<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Age Field Formatter — agent index

One field formatter that turns a core `datetime` field value into an age in whole years. Configured per field on **Manage display**; no global config page (`configure` null), no permissions, no Drush. Depends on core `datetime`.

- **The `age_field_formatter` formatter, its settings keys, display modes, and how to set it via Drush** → [configure/formatter.md](configure/formatter.md)

Key facts:
- Plugin: `@FieldFormatter(id = "age_field_formatter")` for field type `datetime` (`src/Plugin/Field/FieldFormatter/AgeFieldFormatter.php`).
- Age = `DrupalDateTime($value)->diff(now)->y` (full years).
- Settings live in `core.entity_view_display.*` component `settings` (schema `field.formatter.settings.age_field_formatter`).
