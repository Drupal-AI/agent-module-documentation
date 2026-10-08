# field_group_background_image — agent start

Adds one **Field Group** display formatter, `background_image` (class `BackgroundImage`
extends `FieldGroupFormatterBase`), that renders a field group as a `<div>` with a CSS
`background-image` pulled from an image or media field on the same entity. View context only.
Requires `field_group` (and optionally contrib `color_field` for the background-color
option). No settings page / permissions / Drush — configured per group in Manage display.

- Formatter settings keys, image/media resolution, color field, hide-if-missing → [configure/field_group_background_image.md](configure/field_group_background_image.md)
