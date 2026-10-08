<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Readonly Html Field (readonly_html_field) — agent index

**A `readonly_html_field` field type that displays fixed, per-language WYSIWYG HTML read-only on add/edit forms and on display; the value lives in field settings, not per entity.**

- **Version:** 2.0.x
- **Core:** ^11
- **Depends on:** Drupal core only (Field, Filter, Field UI to configure)
- **Field type:** `readonly_html_field` (category `formatted_text`); `isEmpty()` is always TRUE (stores nothing).
- **Config:** per-language `text_format` value in the field *settings* form (default format `basic_html`).
- **Widget / Formatter:** `readonly_html_field_widget` / `readonly_html_field_formatter` — both render the configured HTML via core `check_markup()` for the current language (fallback to default language).
- **Routes/permissions/services:** none.

**Security:** no routes or endpoints; configured HTML is always filtered through `check_markup()` with the chosen text format (not printed raw). Choose a restricted format (e.g. `basic_html`) when less-trusted roles configure the field.

See [configure/field.md](configure/field.md)
