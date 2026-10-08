<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Button' paragraph type (drowl_paragraphs_bs_type_button)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_button -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `micon:micon_link`, `fences:fences`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_link` (link) and `field_settings`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_button_preprocess_paragraph()` (bundle `button`) builds a `button_attributes` `Attribute` object. It moves `btn-*` and `text-*` classes from the paragraph wrapper onto the button, and for `btn__`/`rounded-`/`bg-`/`text-` prefixed classes strips the `btn__` prefix before adding them to the button.

## Template

`templates/paragraph--drowl-paragraphs-bs--button.html.twig` merges the link field's option attributes into `button_attributes`, reads the Micon icon from `content.field_link.0['#title'].icon` and the position from the link's `data-icon-position` attribute, then renders `<a{{ button_attributes.addClass(['btn']) }} href="{{ paragraph.field_link.0.url.toString }}">` with the icon and a `.btn__label` span. Requires the Micon module link formatter to resolve the icon.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
