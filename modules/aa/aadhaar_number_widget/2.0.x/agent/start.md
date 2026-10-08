<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aadhaar Number Widget (aadhaar_number_widget) — agent index

Provides one Field API widget that validates an Indian Aadhaar number (12-digit UIDAI ID) by
format and Verhoeff checksum when a core `string` field is edited. Version **2.0.0**;
core `^8.8 || ^9 || ^10 || ^11`.

- **Dependency:** `drupal:text` (core). No composer.json, no third-party libraries.
- **Provides:** one `@FieldWidget` plugin `aadhaar_number_widget` (class `AadhaarNumberWidget`,
  `field_types = {"string"}`). No formatter, no settings form, no routes, no permissions,
  no services, no config/schema, no `.install`. Only hook: `aadhaar_number_widget_help()`.
- **Validation:** regex accepts `\d{12}`, `\d{4} \d{4} \d{4}`, or `\d{4}-\d{4}-\d{4}`; then
  `isAadhaarValid()` strips separators and compares the last digit to `calculateChecksumDigit()`
  (Verhoeff dihedral D5 tables). Invalid → `$form_state->setError()` blocks save.
- **Note:** the widget only validates input; it does not mask, encrypt, or restrict display of
  the stored value — that stays a site-builder responsibility.

Solution docs:
- [Field widget & Verhoeff validation](fields/widget.md)
