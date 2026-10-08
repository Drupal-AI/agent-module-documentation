<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Text' paragraph type (drowl_paragraphs_bs_type_text)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_text -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_text` (formatted/long text) and `field_settings`.

## `.module` / template

None. The submodule ships only config (`paragraphs.paragraphs_type.text`, `field.field.paragraph.text.field_text`, `field_settings`, the entity form/view displays and optional language content settings). Rendering uses the base module's `paragraph--drowl-paragraphs-bs.html.twig`.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
