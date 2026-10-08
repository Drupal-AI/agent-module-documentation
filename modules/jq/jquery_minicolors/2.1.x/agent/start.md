# jQuery MiniColors — agent index

A color-picker **field widget** (`jquery_minicolors_widget`) for `string` (Text plain) fields,
extending core `StringTextfieldWidget`. Stores the color as a plain string. No config object of its
own, no permissions, no Drush, no plugin type. Needs the external jQuery MiniColors JS library.

- **Attach the widget to a string field; every widget setting; the library requirement** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget id `jquery_minicolors_widget`; field type `string`; set via **Manage form display**.
- Per-widget settings (schema `field.widget.settings.jquery_minicolors_widget`): `control`,
  `format` (hex/rgb), `opacity`, `swatches`, `position`, `theme`, `inline`, `animation_speed`,
  `animation_easing`, `change_delay`, `letter_case`, `show_speed`, `hide_speed`, `keywords`, `size`,
  `placeholder`.
- Requires the jQuery MiniColors library v2.2.4 at `/libraries/jquery-minicolors/`
  (`jquery.minicolors.min.js` + `jquery.minicolors.css`); `hook_requirements()` flags it if missing.
- No `configure` route — everything is per-field on the form display.
