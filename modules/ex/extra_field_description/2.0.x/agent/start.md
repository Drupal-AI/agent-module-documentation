<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field Description — agent index

Adds an "extra description" that renders **above** a field widget on entity edit forms (configured per field on *Manage form display*). No global config page (`configure` null), no config schema. Provides one permission (`administer field prefix`). Pure `.module` hooks + a CSS library.

- **The `extra_description` widget third-party setting, where it's stored, the permission gate, and the raw-HTML caveat** → [configure/field-description.md](configure/field-description.md)

Key facts:
- Setting added via `hook_field_widget_third_party_settings_form` on non-base fields; UI gated by `administer field prefix`.
- Stored at `entity_form_display … content.<field>.third_party_settings.extra_field_description.extra_description.over_description`.
- Rendered via `hook_field_widget_single_element_form_alter` as a `#field_prefix` `<div class="extra-description">` (raw markup, not filtered).
- CSS: library `extra_field_description/extra_field_description_css` (`css/efd.css`), attached on all pages.
