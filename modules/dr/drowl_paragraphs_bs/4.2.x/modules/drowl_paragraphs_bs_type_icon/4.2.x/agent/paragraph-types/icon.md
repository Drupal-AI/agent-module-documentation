<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Icon' paragraph type (drowl_paragraphs_bs_type_icon)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_icon -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `link_attributes:link_attributes`, `micon:micon`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_icon` (Micon icon), `field_link`, `field_subtitle`, `field_text`, `field_title`, and `field_settings`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_icon_preprocess_paragraph()` (bundle `icon`) builds `icon_combo_attributes` and `icon_attributes`. It routes classes: `icon-combo--*` and `align-items-*`/`justify-content-*` to the combo; `icon-combo__*` to the combo with the prefix stripped; `icon__*` to the icon with the prefix stripped.

## Templates

`templates/paragraph--drowl-paragraphs-bs--icon.html.twig` renders the combo as an `<a>` (when linked) or `<div>`, an `<i>` icon element, and a text wrapper with `<h3>` title, subtitle and body text. `templates/fields/field--field-paragraphs-icon.html.twig` is a trimmed field template for icon fields.

## UI Styles

`drowl_paragraphs_bs_type_icon.ui_styles.yml` defines icon position, combo/icon alignment, icon colour, style (simple / circle / hollow circle), circle background colour and size.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
